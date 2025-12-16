import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_login_app/login_page.dart'; // Adjust import to match your app name

void main() {
  testWidgets('Login page displays correctly', (WidgetTester tester) async {
    // Build the LoginPage widget
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Verify the app bar title
    expect(find.text('Login'), findsOneWidget);

    // Verify email and password text fields are present
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify the sign-in button is present
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
