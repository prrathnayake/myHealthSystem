import 'dart:convert';

import 'package:e_health/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_health/models/user.dart' as model;

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();

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
    _firstNameController.text = userCredentials['firstName'];
    _lastNameController.text = userCredentials['lastName'];
    _usernameController.text = userCredentials['username'];
    _mobileController.text = userCredentials['mobile'];
    _nicController.text = userCredentials['nic'];
  }

  void saveChanges() async {
    String res = await AuthMethods().changeData(
        uid: userCredentials['uid'],
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        username: _usernameController.text,
        nic: _nicController.text,
        mobile: _mobileController.text);

    if (res == 'success') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("userCredentials");
      model.User userCredentials = await AuthMethods().getUserDetails();
      String json = jsonEncode(userCredentials);
      prefs.setString('userCredentials', json);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Account Details',
                style: TextStyles.textHeader1.copyWith(
                  fontSize: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: false,
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'First name',
                      labelStyle: TextStyles.inputlabel,
                      hintText: 'Enter your first name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: false,
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Last name',
                      labelStyle: TextStyles.inputlabel,
                      hintText: 'Enter your last name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: false,
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Username',
                        labelStyle: TextStyles.inputlabel,
                        hintText: 'Enter your username'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: false,
                    controller: _nicController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'NIC',
                        labelStyle: TextStyles.inputlabel,
                        hintText: 'Enter your NIC'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: false,
                    controller: _mobileController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Mobile',
                        labelStyle: TextStyles.inputlabel,
                        hintText: 'Enter your mobile number'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: saveChanges,
                  child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: CustomColors.buttonPrimary,
                          borderRadius: BorderRadius.circular(3)),
                      child: const Center(child: Text('Save Changes'))))
            ],
          ),
        ),
      ),
    );
  }
}
