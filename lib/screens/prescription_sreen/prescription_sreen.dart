import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_health/screens/document_screen/components/pdfViewer.dart';
import 'package:e_health/screens/prescription_sreen/components/prescription_card.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  Map<String, dynamic> userCredentials = {'': ''};
  bool isLoading = false;

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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Prescription',
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
                          .collection('prescriptions')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => PdfViewer(
                                                  url: snapshot
                                                      .data!.docs[index]
                                                      .get('url'),
                                                  title: snapshot
                                                      .data!.docs[index].id,
                                                )));
                                  },
                                  child: PrescriptionCard(
                                    name: snapshot.data!.docs[index].id,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
