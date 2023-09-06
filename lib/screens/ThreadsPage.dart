import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThreadsPage extends StatefulWidget {
  const ThreadsPage({super.key});

  @override
  State<ThreadsPage> createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: const [Icon(Icons.exit_to_app)],
      ),
    );
  }
}
