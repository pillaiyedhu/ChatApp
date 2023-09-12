import 'package:chatapp/entity/messageEntity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String threadId, String message) async {
    final String currentUserId = auth.currentUser!.uid;
    //final String currentUserEmail = auth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    //message
    MessageEntity newMessage = MessageEntity(
        senderId: currentUserId,
        threadId: threadId,
        message: message,
        timestamp: timeStamp);

    //room to save chats
    // List<String> uids = [currentUserId, recieverId];
    // uids.sort();
    // String chatRoomId = uids.join('_');

    await firebaseFirestore
        .collection('chat_rooms')
        .doc(threadId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String currentUserId, String threadId) {
    // List<String> uids = [currentUserId, recieverId];
    // uids.sort();
    // String chatRoomId = uids.join('_');
    return firebaseFirestore
        .collection('chat_rooms')
        .doc(threadId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
