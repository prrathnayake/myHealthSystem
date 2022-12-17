import 'dart:convert';

import 'package:e_health/resources/auth_methods.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:e_health/models/user.dart' as model;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> userCredentials = {'username': ' '};

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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hi, ${userCredentials['username']} 👋',
                    style: TextStyles.textHeader1.copyWith(fontSize: 40),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: const AssetImage('assets/images/appointment_bg.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        CustomColors.lightBlue.withOpacity(0.5),
                        BlendMode.dstATop),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Manage your appointment",
                    style: TextStyles.textHeader2
                        .copyWith(fontSize: 30, color: CustomColors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
