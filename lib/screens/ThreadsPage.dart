import 'package:chatapp/screens/ChatPage.dart';
import 'package:chatapp/screens/UsersPage.dart';
import 'package:chatapp/services/ThreadService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThreadsPage extends StatefulWidget {
  final String? recieverId;
  final String? threadName;
  const ThreadsPage({this.recieverId, this.threadName, super.key});

  @override
  State<ThreadsPage> createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final Timestamp timestamp = Timestamp.now();
  ThreadService threadService = ThreadService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: const [Icon(Icons.exit_to_app)],
      ),
      body: threadList(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UsersPage(),
            ));
          }),
    );
  }

  Widget threadList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('threads').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('errror');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Waiting');
        }

        return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => singleThread(doc))
                .toList());
      },
    );
  }

  Widget singleThread(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (auth.currentUser!.uid == data['currentUserId'] ||
        auth.currentUser!.uid == data['recieverId']) {
      return ListTile(
        title: Text(data['threadName']),
        onTap: () {
          print(data['threadId']);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    threadName: data['threadName'], threadId: data['threadId']),
              ));
        },
      );
    } else {
      return Container(
        // child: Text('No data'),
      );
    }
  }
  //   return ListTile(
  //     title: Text(data['uid']),
  //   );
  // }
}
