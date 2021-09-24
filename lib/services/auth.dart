import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

abstract class AuthBase {
  User? get currentUser;
  Future<UserCredential> signInWithGoogle();
  Future<User?> signInWithFaceBook();
  Stream<User?> authStateChanges();
  // Future<void> signOut();
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return userCredential;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLEID_TOKEN',
          message: 'MISSING GOOGLE ID TOKEN',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'SIGN IN ABORTED BY USER',
      );
    }
  }

  @override
  Future<User?> signInWithFaceBook() async {
    final fb = FacebookLogin();
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final accessToken = res.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken!.token));
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in is aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: res.error!.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }
}
