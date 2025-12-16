import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supabase_login_app/main.dart'; // Adjust import to match your app name

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login integration test', (WidgetTester tester) async {
    // Start the app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(); // Wait for app to settle

    // Verify we're on the login page
    expect(find.text('Login'), findsOneWidget);

    // Enter email
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');

    // Enter password
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Tap the sign-in button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Note: For a complete integration test, you might need to mock Supabase
    // or use a test account. This example shows the basic flow.
    // In a real scenario, check for navigation to the next screen or error messages.
  });
}
