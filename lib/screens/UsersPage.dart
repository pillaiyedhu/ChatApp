import 'package:chatapp/screens/ChatPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
      body: UserList(),
    );
  }

  Widget UserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('errror');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Waiting');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => SingleUser(doc))
              .toList(),
        );
      },
    );
  }

  Widget SingleUser(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    recieverMail: data['email'], recieverId: data['uid']),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
