import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_login_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase here for integration tests because tests instantiate
  // `MyApp` directly (they don't call `main()`), so we must initialize the
  // client before the app uses `Supabase.instance`.
  const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  setUpAll(() async {
    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      fail(
        'Integration test requires SUPABASE_URL and SUPABASE_ANON_KEY passed via --dart-define',
      );
    }

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    print('Integration test: Supabase initialized');
  });

  testWidgets('Login integration test', (WidgetTester tester) async {
    // Success case: valid credentials
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton));

    // Wait for network + UI (snackbar) to settle
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verify Supabase current user is present after successful login
    expect(Supabase.instance.client.auth.currentUser, isNotNull);
    expect(find.text('Login successful!'), findsOneWidget);
    // Sign out to ensure clean state for subsequent tests
    await Supabase.instance.client.auth.signOut();
  });

  testWidgets('Login integration test - failure (wrong password)', (
    WidgetTester tester,
  ) async {
    // Failure case: invalid password should NOT set a current user
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);

    // Ensure no leftover session
    await Supabase.instance.client.auth.signOut();

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'wrong-password');
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    // After failed login, currentUser should be null and success message absent
    expect(Supabase.instance.client.auth.currentUser, isNull);
    expect(find.text('Login successful!'), findsNothing);
  });
}
