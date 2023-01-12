import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_health/resources/chat_methods.dart';
import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({super.key});

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _textController = TextEditingController();

  void _reset() {
    _textController.clear();
  }

  onPress() {
    ChatMethods().sendMessgae({
      "message": _textController.text,
      "senderName": "pasan ransika",
      'createdOn': FieldValue.serverTimestamp()
    });
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
