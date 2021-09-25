import 'package:firebase_authentication/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final AuthBase? auth;
  const HomePage({Key? key, @required this.auth}) : super(key: key);

  Future<void> _signOut() async {
    try {
      await auth!.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _signOut,
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
