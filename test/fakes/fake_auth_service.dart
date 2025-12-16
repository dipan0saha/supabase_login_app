import 'package:supabase_login_app/auth/auth_service.dart';

class FakeAuthService implements AuthService {
  bool _signedIn = false;

  @override
  Future<bool> signIn(String email, String password) async {
    // deterministic fake: only one credential pair succeeds
    if (email == 'test@example.com' && password == 'password123') {
      _signedIn = true;
      return true;
    }
    _signedIn = false;
    return false;
  }

  @override
  Future<void> signOut() async {
    _signedIn = false;
  }

  bool get isSignedIn => _signedIn;
}
