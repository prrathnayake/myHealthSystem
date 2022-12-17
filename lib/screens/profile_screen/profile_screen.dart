import 'dart:convert';

import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/profileImage.jpg'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${userCredentials['firstName']} ${userCredentials['lastName']}',
              style: TextStyles.textHeader2,
            )
          ],
        ),
      ),
    );
  }
}
