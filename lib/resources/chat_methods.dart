import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessge(
      {required Map<String, dynamic> data,
      required roomID,
      required receiverID}) async {
    await _firestore
        .collection("chats")
        .doc(roomID)
        .collection("messages")
        .add(data);

    await _firestore
        .collection("users")
        .doc(data['senderUID'])
        .collection("chats")
        .doc(roomID)
        .set({"lastMessage": data['message'], "recieverUID": receiverID});

    await _firestore
        .collection("users")
        .doc(receiverID)
        .collection("chats")
        .doc(roomID)
        .set(
            {"lastMessage": data['message'], "recieverUID": data['senderUID']});
  }

  // Future<List<Map<String, dynamic>>> getMessages({required docID}) async {
  //   var messages = <Map<String, dynamic>>[];

  //   QuerySnapshot querySnapshot = await _firestore
  //       .collection("chats")
  //       .doc(docID)
  //       .collection("messages")
  //       .get();

  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     messages.add(
  //         {'senderName': a.get('senderName'), 'message': a.get('message')});
  //   }
  //   return messages;
  // }
}
