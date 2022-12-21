import 'dart:convert';
import 'dart:io';

import 'package:e_health/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../utils/styles.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  PlatformFile? pickerfile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickerfile = result.files.first;
    });
  }

  Future uploadFile() async {
    try {
      if (pickerfile == null) return print('null');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? json = prefs.getString('userCredentials');
      final Map<String, dynamic> userCredentials = jsonDecode(json!);

      final path = 'Documents/${userCredentials['uid']}/${pickerfile!.name}';
      final file = File(pickerfile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();

      var collection = FirebaseFirestore.instance.collection('users');

      collection
          .doc(userCredentials['uid'])
          .collection('urls')
          .doc(pickerfile!.name)
          .get()
          .then((sanphot) => collection
              .doc(userCredentials['uid'])
              .collection('urls')
              .doc(pickerfile!.name)
              .delete());

      collection
          .doc(userCredentials['uid'])
          .collection('urls')
          .doc(pickerfile!.name)
          .set({'url': urlDownload});

      setState(() {
        pickerfile = null;
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Documents',
              style: TextStyles.textHeader1.copyWith(
                fontSize: 40,
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pickerfile != null
                          ? Text(pickerfile!.name)
                          : const Text("no file seletced"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: pickerfile != null
          ? SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                    child: const Icon(Icons.done),
                    label: 'Upload',
                    onTap: uploadFile),
                SpeedDialChild(
                    child: const Icon(Icons.delete),
                    label: 'Remove',
                    backgroundColor: Colors.red,
                    onTap: () {
                      setState(() {
                        pickerfile = null;
                      });
                    }),
              ],
            )
          : FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: selectFile,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
    );
  }
}
