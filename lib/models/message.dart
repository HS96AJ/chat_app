import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String recieiverID;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.recieiverID,
      required this.senderEmail,
      required this.senderID,
      required this.timestamp});

  Map<String,dynamic> toMap (){
    return {
      "senderID" : senderID,
      "senderEmail": senderEmail,
      "recieiverID" : recieiverID,
      "message" : message,
      "Timestamp" : timestamp
    };
  }
}
