import 'dart:convert';

import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key, required this.id});
  final int id;
  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  late Map<String, dynamic> userCredentials = {'': ''};
  List? doctor = [
    {"": ""}
  ];
  bool isLoading = true;

  getDoctorDetails() async {
    List data =
        await APImethods().getDoctorByID(doctorID: widget.id.toString());

    setState(() {
      doctor = data;
      isLoading = false;
    });
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
    getDoctorDetails();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  // Container(
                  //   width: double.infinity,
                  //   height: 300,
                  //   child: Image.network(
                  //     imageUrl,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          doctor![0]['firstName'],
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          doctor![0]['areaID'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          doctor![0]['email'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          doctor![0]['mobile'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          doctor![0]['area'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                        roomId:
                                            '${userCredentials['uid']}${doctor![0]['firebaseUID']}',
                                        receiverUID:
                                            '${doctor![0]['firebaseUID']}',
                                        receiverName:
                                            '${doctor![0]['firstName']} ${doctor![0]['lastName']}',
                                      )));
                            },
                            icon: const Icon(Icons.message))
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
