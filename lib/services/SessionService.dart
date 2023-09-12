import 'dart:async';

import 'package:chatapp/screens/LoginPage.dart';
import 'package:chatapp/screens/UsersPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SessionService {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      // Timer(const Duration(seconds: 2), ()=> Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => UsersPage(),
      //     )));
      
    } else {
      Timer(const Duration(seconds: 2), ()=> Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          )));
    }
  }
}
