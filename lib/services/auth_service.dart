import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        await user.updateDisplayName(name); // Set user name
        await user.reload(); // Refresh user data
        return _auth.currentUser; // Return the newly signed up user
      } else {
        return null;
      }
    } catch (e) {
      throw e; // Throw error to show on UI
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
