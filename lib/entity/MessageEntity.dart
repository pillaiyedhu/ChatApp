import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  final String senderId;
  final String? senderEmail;
  final String recieverId;
  //final String? recieverMail;
  final String message;
  final Timestamp timestamp;

  MessageEntity(
      {required this.senderId,
      this.senderEmail,
      required this.recieverId,
      //this.recieverMail,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId':senderId,
      'recieverId':recieverId,
      'message':message,
      'timeStamp':timestamp
    };
  }
}
