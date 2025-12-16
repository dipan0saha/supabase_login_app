import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';

class SupabaseAuthService implements AuthService {
  final _client = Supabase.instance.client;

  @override
  Future<bool> signIn(String email, String password) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res.user != null;
  }

  @override
  Future<void> signOut() => _client.auth.signOut();
}
