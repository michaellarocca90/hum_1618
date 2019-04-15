import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


// Abstract Class - Ensuring Methods for FirebaseAuthorization Class
abstract class AbsFireBaseAuthorization {
  Future<String> loginExistingUser(String email, String password);

  Future<String> registerNewUser(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}



// FireBase Methods for sending and reciveing user profile data
class FireBaseAuthorization implements AbsFireBaseAuthorization {

  // Entry Point for Firebase SDK
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Loging Entry Point for existing User
  Future<String> loginExistingUser(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  // Registering New User
  Future<String> registerNewUser(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  // Getting Current User
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  // Signing Out for Current User
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }


  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

}