import 'dart:convert';

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
                            'Personal Details',
                            style: TextStyles.textHeader2.copyWith(
                                color: CustomColors.black, fontSize: 30),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Username  - ',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                ),
                                Text(
                                  '${userCredentials['username']}',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'email  - ',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                ),
                                Text(
                                  '${userCredentials['email']}',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Mobile  - ',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                ),
                                Text(
                                  '${userCredentials['mobile']}',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'NIC  - ',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                ),
                                Text(
                                  '${userCredentials['nic']}',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
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
