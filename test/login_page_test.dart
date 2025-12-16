import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_login_app/login_page.dart'; // Adjust import to match your app name
import 'fakes/fake_auth_service.dart';

void main() {
  testWidgets('Login page displays correctly', (WidgetTester tester) async {
    // Build the LoginPage widget with a fake auth service
    final fakeAuth = FakeAuthService();
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: fakeAuth)));

    // Verify the app bar title
    expect(find.text('Login'), findsOneWidget);

    // Verify email and password text fields are present
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify the sign-in button is present
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Login widget success uses fake auth', (
    WidgetTester tester,
  ) async {
    final fakeAuth = FakeAuthService();
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: fakeAuth)));

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Login successful!'), findsOneWidget);
  });
}
