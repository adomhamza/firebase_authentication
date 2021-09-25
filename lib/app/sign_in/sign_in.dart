import 'package:firebase_authentication/app/sign_in/signin_buttons/custom_raised_btn.dart';
import 'package:firebase_authentication/services/auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  final AuthBase? auth;
  const SignInPage({Key? key, @required this.auth}) : super(key: key);

  Future<void> _signInWithGoogle() async {
    try {
      await auth!.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomRaisedButton(
            child: const BuildRow(
              image: 'assets/google-logo.png',
              text: 'Sign In With Google',
              textColor: Colors.black,
            ),
            onPressed: _signInWithGoogle,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
