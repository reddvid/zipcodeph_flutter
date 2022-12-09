import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/firebase_service.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton.icon(
                label: const Text("Sign in with Google"),
                icon: const FaIcon(FontAwesomeIcons.google),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final service = FirebaseService();
                  try {
                    await service.signInWithGoogle();
                    Navigator.of(context).pop();
                  } catch (e) {
                    if (e is FirebaseAuthException) {
                      showMessage(e.message!);
                    }
                  }
                  setState(() {
                    isLoading = false;
                  });
                }))
        : const CircularProgressIndicator();
  }

  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop;
              },
            ),
          ],
        );
      },
    );
  }
}
