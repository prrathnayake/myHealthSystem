import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessgae(Map<String, dynamic> data) async {
    Future<void> doc = _firestore
        .collection("chats")
        .doc("83hjVJaxaVbf2lxo0GAV")
        .collection("messages")
        .doc()
        .set(data);
  }

  Future<List<Map<String, dynamic>>> getMessages() async {
    var messages = <Map<String, dynamic>>[];

    QuerySnapshot querySnapshot = await _firestore
        .collection("chats")
        .doc("83hjVJaxaVbf2lxo0GAV")
        .collection("messages")
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      messages.add(
          {'senderName': a.get('senderName'), 'message': a.get('message')});
    }
    return messages;
  }
}
