import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThreadService extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future save(
      String currentUserId, String recieverId, String threadName) async {
    List<String> uids = [currentUserId, recieverId];
    uids.sort();
    String threadId = uids.join('_');

    await firebaseFirestore.collection('threads').doc(threadId).set({
      'threadId': threadId,
      'currentUserId': currentUserId,
      'recieverId': recieverId,
      'threadName': threadName
    });
  }

  // Future getThread(String currentUserId,String recieverId,String threadName) async {
  //    List<String> uids = [currentUserId, recieverId, threadName];
  //   uids.sort();
  //   String threadId = uids.join('_');

  //   firebaseFirestore.collection('threads').doc(threadId).get();
  // }

  Stream<QuerySnapshot> getThread(String currentUserId, String recieverId) {
    List<String> uids = [currentUserId, recieverId];
    uids.sort();
    String chatRoomId = uids.join('_');
    return firebaseFirestore
        .collection('threads')
        .doc(chatRoomId)
        .collection('threadNames')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }

  
}
