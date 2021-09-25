import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/app/home_page/home_page.dart';
import 'package:firebase_authentication/app/sign_in/sign_in.dart';
import 'package:firebase_authentication/services/auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final AuthBase? auth;

  const LandingPage({
    Key? key,
    @required this.auth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: auth!.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInPage(auth: auth);
            }
            return HomePage(auth: auth);
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
