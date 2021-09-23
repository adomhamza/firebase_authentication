import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInWithGoogle();
  Future<User> signInWithFaceBook();
  Stream<User> authStateChanges();
  Future<void> signOut();
}
