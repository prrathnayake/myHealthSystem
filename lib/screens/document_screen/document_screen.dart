import 'dart:convert';

import 'package:e_health/resources/store_methods.dart';
import 'package:e_health/screens/document_screen/components/pdfViewer.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  PlatformFile? pickerfile;
  UploadTask? uploadTask;
  Map<String, dynamic> userCredentials = {'': ''};
  bool isLoading = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;

    setState(() {
      pickerfile = result.files.first;
    });
  }

  Future uploadFile() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (pickerfile == null) return null;
      await StoreMethods()
          .uploadFile(pickerfile: pickerfile!, uid: userCredentials['uid']);

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
    setState(() {
      isLoading = false;
    });
  }

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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Documents',
                        style: TextStyles.textHeader1.copyWith(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  !isLoading
                      ? Flexible(
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc('${userCredentials['uid']}')
                                .collection('urls')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PdfViewer(
                                                        url: snapshot
                                                            .data!.docs[index]
                                                            .get('url'),
                                                        title: snapshot.data!
                                                            .docs[index].id,
                                                      )));
                                        },
                                        child: Text(
                                          snapshot.data!.docs[index].id,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text('Error');
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        )
                      : const Flexible(
                          child: Center(child: CircularProgressIndicator())),
                ],
              ),
            ),
            pickerfile != null
                ? Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.5)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('File Selected'),
                            Text(pickerfile!.name),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
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
