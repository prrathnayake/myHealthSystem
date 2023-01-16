import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_health/resources/chat_methods.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextComposer extends StatefulWidget {
  const TextComposer(
      {super.key,
      required this.roomID,
      required this.receiverUID,
      required this.receiverName});
  final String receiverUID;
  final String receiverName;
  final String roomID;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  late Map<String, dynamic> userCredentials = {'': ''};
  final _textController = TextEditingController();

  void _reset() {
    _textController.clear();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('userCredentials');

    setState(() {
      userCredentials = jsonDecode(json!);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  onPress() {
    ChatMethods().sendMessge(
        data: {
          "message": _textController.text,
          "senderName": userCredentials['firstName'],
          "senderUID": userCredentials['uid'],
          'createdOn': FieldValue.serverTimestamp()
        },
        roomID: widget.roomID,
        receiverID: widget.receiverUID,
        receiverName: widget.receiverName);
    _reset();
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColorDark),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (text) {
                  // send message
                  _reset();
                },
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: onPress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
