import 'dart:convert';

import 'package:e_health/screens/account_details_screen/account_details_screen.dart';
import 'package:e_health/screens/document_screen/document_screen.dart';
import 'package:e_health/screens/password_change_screen/password_change_screen.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/auth_methods.dart';
import '../login_screen/login_screen.dart';

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
    return Container(
      color: CustomColors.lightBlue,
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor: CustomColors.white,
                            child: const CircleAvatar(
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
                        style: TextStyles.textHeader2
                            .copyWith(color: CustomColors.white),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Logout....'),
                        content:
                            const Text('Are you sure, you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await AuthMethods().signOut();
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove("userCredentials");
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text('Sure'),
                          ),
                        ],
                      ),
                    ),
                    icon: Icon(
                      Icons.logout,
                      color: CustomColors.white,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: CustomColors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile Settings',
                            style: TextStyles.textHeader2.copyWith(
                                color: CustomColors.black, fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const AccountDetailsScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.manage_accounts),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Account details',
                                    style: TextStyles.regulerText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: CustomColors.black),
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DocumentScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.file_copy),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Documents',
                                    style: TextStyles.regulerText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: CustomColors.black),
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const PasswordChangeScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.lock_outline),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Change Password',
                                    style: TextStyles.regulerText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: CustomColors.black),
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
