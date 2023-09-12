import 'package:cloud_firestore/cloud_firestore.dart';

class ThreadEntity {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String recieverEmail;
  final String threadName;
  final Timestamp timestamp;

  ThreadEntity(
      {required this.senderId,
      required this.senderEmail,
      required this.recieverId,
      required this.recieverEmail,
      required this.threadName,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId':senderId,
      'senderEmail':senderEmail,
      'recieverId':recieverId,
      'recieverEmail':recieverEmail,
      'threadName':threadName,
      'timestamp':timestamp
    };
  }
}
