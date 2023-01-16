import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_health/screens/chat_screen/components/message_card.dart';
import 'package:e_health/screens/chat_screen/components/textComposer.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.roomId,
      required this.receiverUID,
      required this.receiverName});
  final String roomId;
  final String receiverUID;
  final String receiverName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<List<Map<String, dynamic>>> messages;

  // @override
  // void initState() {
  //   super.initState();
  //   messages = ChatMethods().getMessages();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("chats")
                    .doc(widget.roomId)
                    .collection("messages")
                    .orderBy('createdOn')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: MessageCard(snapshot.data!.docs[index]));
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              // FutureBuilder<List<Map<String, dynamic>>>(
              //   future: messages,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return ListView.builder(
              //         reverse: true,
              //         itemCount: snapshot.data?.length,
              //         itemBuilder: (context, index) {
              //           return MessageCard(snapshot.data![index]);
              //         },
              //       );
              //     } else if (snapshot.hasError) {
              //       return Text("${snapshot.error}");
              //     }
              //     return const Center(child: CircularProgressIndicator());
              //   },
              // ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(
                  roomID: widget.roomId,
                  receiverUID: widget.receiverUID,
                  receiverName: widget.receiverName),
            ),
          ],
        ),
      ),
    );
  }
}
