import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_health/screens/chat_list_screen/components/chat_card.dart';
import 'package:e_health/screens/chat_screen/chat_screen.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  Map<String, dynamic> userCredentials = {'': ''};
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('userCredentials');

    setState(() {
      userCredentials = jsonDecode(json!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chats',
                    style: TextStyles.textHeader1.copyWith(
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc('${userCredentials['uid']}')
                      .collection('chats')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    roomId: snapshot.data!.docs[index].id,
                                    receiverUID: snapshot.data!.docs[index]
                                        .get("receiverUID"),
                                  ),
                                ));
                              },
                              child: ChatCard(
                                name: snapshot.data!.docs[index]
                                    .get("receiverUID"),
                              ),
                            ),
                          );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
