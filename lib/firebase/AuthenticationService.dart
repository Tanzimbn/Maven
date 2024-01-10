
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {
  final FirebaseAuth _firebaseauth;
  AuthenticationService(this._firebaseauth);

  Stream<User?> get authStateChanges => _firebaseauth.authStateChanges();

  Future<String> signIn(
    {required String email, required String password}) async {
      try {
        await _firebaseauth.signInWithEmailAndPassword(
          email: email, password: password
        );
        return "ok";
      } on FirebaseAuthException catch(e) {
        return e.message.toString();
      }
    }

  Future<void> SignOut () async {
    await _firebaseauth.signOut();
  }
}