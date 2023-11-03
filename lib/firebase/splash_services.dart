import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthexample/ui/auth/home_screen.dart';
import 'package:firebaseauthexample/ui/auth/login.dart';
import 'package:flutter/material.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void isLogIn(BuildContext context) {
    if (_auth.currentUser != null) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        ),
      );
    }
  }
}
