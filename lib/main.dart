import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    const String supabaseUrlConst = String.fromEnvironment('SUPABASE_URL');
    const String supabaseAnonKeyConst = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
    );

    final String supabaseUrl = supabaseUrlConst.isNotEmpty
        ? supabaseUrlConst
        : ''; // will be empty if not provided via --dart-define
    final String supabaseAnonKey = supabaseAnonKeyConst.isNotEmpty
        ? supabaseAnonKeyConst
        : '';

    if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    }
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
