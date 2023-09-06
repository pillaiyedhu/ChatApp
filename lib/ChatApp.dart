import 'package:chatapp/screens/LoginPage.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme:ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
