import 'dart:io';

import 'package:chatapp/services/ChatService.dart';
import 'package:chatapp/services/ThreadService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String threadName;
  final String threadId;

  const ChatPage(
      {required this.threadName, required this.threadId, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();
  ChatService chatService = ChatService();
  FirebaseAuth auth = FirebaseAuth.instance;
  //final threadService = Provider.of<ThreadService>(context, listen: false);

  //image
  File? image;
  final imagePicker = ImagePicker();
  String? downloadUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.threadName),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          actions: const [Icon(Icons.exit_to_app)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              previousChatView(),
              chatInput(),
            ],
          ),
        ));
  }

  Widget previousChatView() {
    return StreamBuilder(
        stream:
            chatService.getMessage(auth.currentUser!.uid,widget.threadId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loadiing');
          }
          //final document = snapshot.data!.docs;
          //print(document);
          //print('check1');

          // return SingleChildScrollView(
          //   child: Container(
          //     height: 300,
          //     width: 300,
          //     //child:Text("")
          // child: ListView(
          //     children: document
          //         .map((document) => previousChatItem(document))
          //         .toList()),
          //   ),
          // );

          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * (0.8),
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: snapshot.data!.docs.isNotEmpty
                  ? ListView(
                      children: List.generate(
                              snapshot.data!.docs.length,
                              (index) =>
                                  previousChatItem(snapshot.data!.docs[index]))
                          .toList(),
                    )
                  : const Center(
                      child: Text('No message'),
                    ),
            ),
          );
        });
  }

  Widget previousChatItem(DocumentSnapshot document) {
    //print('hello');
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.bottomRight
        : Alignment.bottomLeft;
    return Container(
        alignment: alignment,
        child: Text(
          data['message'],
          style: const TextStyle(color: Colors.white, fontSize: 16),
        )
        // child: Card(
        //   color: Colors.cyan,
        //   margin: const EdgeInsets.all(10),
        //   child: Text(
        //   data['message'],
        //   style: const TextStyle(color: Colors.white),
        // ),
        // )
        );
  }

  Widget chatInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * (0.7),
          child: TextField(
            decoration: const InputDecoration(
                hintText: 'Enter Message',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
            controller: textController,
          ),
        ),

        //image upload...................................
        IconButton(
            onPressed: () {
              ImagePickerMethod();
            },
            icon: Icon(Icons.upload)),

        IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }

  sendMessage() async {
    if (textController.text.isNotEmpty) {
      await chatService.sendMessage(widget.threadId, textController.text);
    }
    textController.clear();
  }

  Future ImagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pick != null) {
      image = File(pick.path);

      uploadImage(File(pick.path));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No image')));
    }
  }

  Future uploadImage(File image) async {
    Reference storage = FirebaseStorage.instance.ref().child('users');
    await storage.putFile(image);
    downloadUrl = await storage.getDownloadURL();
    print(downloadUrl);
  }
}
