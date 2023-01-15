import 'dart:convert';

import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalDetailsScreen extends StatefulWidget {
  const HospitalDetailsScreen({super.key, required this.id});
  final int id;
  @override
  State<HospitalDetailsScreen> createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  late Map<String, dynamic> userCredentials = {'': ''};
  List? hospitals = [
    {"": ""}
  ];
  bool isLoading = true;

  getHospitalDetails() async {
    List data =
        await APImethods().gethospitalsByID(hospitalID: widget.id.toString());

    setState(() {
      hospitals = data;
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
    getHospitalDetails();
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
                          hospitals![0]['name'],
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          hospitals![0]['address'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          hospitals![0]['mobile'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
