import 'package:chatapp/screens/ThreadsPage.dart';
import 'package:chatapp/services/ThreadService.dart';
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
  final TextEditingController threadNameController = TextEditingController();

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
    //String threadName = '';
    if (auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Enter your Thread Name'),
                content: TextField(
                  controller: threadNameController,
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        save(data['uid']);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ThreadsPage(recieverId: data['uid'],threadName: threadNameController.text,)));
                      },
                      child: Text("Ok"))
                ],
              );
            },
          );
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ChatPage(
          //           recieverMail: data['email'], recieverId: data['uid']),
          //     ));
        },
      );
    } else {
      return Container();
    }
  }

  // sendThread() async{
  //   if(threadNameController.text.isNotEmpty){
  //     await threadService.setThreadName(threadNameController.text);
  //   }
  // }

  Future save(String recieverId) async {
    if (threadNameController.text.isNotEmpty) {
      await threadService.save(
          auth.currentUser!.uid, recieverId,threadNameController.text.toString());
    }
  }
}
