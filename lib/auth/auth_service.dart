abstract class AuthService {
  /// Attempt sign in. Return true on success, false on failure.
  Future<bool> signIn(String email, String password);

  /// Sign out current session.
  Future<void> signOut();
}
