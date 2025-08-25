import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Currently signed in user
  User? get currentUser => _auth.currentUser;

  // ----------------- SIGN IN -----------------
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Handle login errors clearly
      if (e.code == 'user-not-found') {
        throw 'No user found with this email. Please sign up first.';
      } else if (e.code == 'wrong-password') {
        throw 'Incorrect password. Please try again.';
      } else if (e.code == 'invalid-credential') {
        throw 'Invalid or expired credentials. Please sign in again.';
      } else {
        throw 'Sign in failed: ${e.message}';
      }
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  // ----------------- SIGN UP -----------------
  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        // Only update display name if provided
        if (name.isNotEmpty) {
          await user.updateDisplayName(name);
          await user.reload();
        }
        return _auth.currentUser;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      // Detailed error handling
      if (e.code == 'email-already-in-use') {
        throw 'This email is already registered. Please sign in instead.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is not valid.';
      } else if (e.code == 'weak-password') {
        throw 'The password is too weak (minimum 6 characters).';
      } else if (e.code == 'operation-not-allowed') {
        throw 'Email/password accounts are not enabled in Firebase Console.';
      } else if (e.code == 'invalid-credential') {
        throw 'The supplied credential is invalid or expired.';
      } else {
        throw 'Sign up failed: ${e.message}';
      }
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  // ----------------- SIGN OUT -----------------
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
