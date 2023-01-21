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

  onPressBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Stack(children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/hospital.jpg'),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 20,
                        left: 10,
                        child: IconButton(
                          onPressed: onPressBack,
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                        )),
                  ]),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              hospitals![0]['name'],
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_city),
                            const SizedBox(width: 10),
                            Text(
                              hospitals![0]['address'].toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.call),
                            const SizedBox(width: 10),
                            Text(
                              hospitals![0]['mobile'],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
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
