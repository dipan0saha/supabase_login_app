import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    print('Supabase initialized');
  } catch (e) {
    print('Initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}
