import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageCard extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> message;

  const MessageCard(this.message, {super.key});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late Map<String, dynamic> userCredentials = {'': ''};
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
    return widget.message["senderUID"] == userCredentials['uid']
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.message["senderName"],
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Text(widget.message["message"]),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profileImage.jpg'),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profileImage.jpg'),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.message["senderName"],
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Text(widget.message["message"]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
