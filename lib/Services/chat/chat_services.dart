import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String recieiverID, String message) async {
    // get current user
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        message: message,
        recieiverID: recieiverID,
        senderEmail: currentUserEmail,
        senderID: currentUserID,
        timestamp: timeStamp);

    // construct chatroom id for the 2 users
    List<String> ids = [currentUserID, recieiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    // add new message to databse
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //Construct a chatroom id for the 2 users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("Timestamp", descending: false)
        .snapshots();
  }
}
