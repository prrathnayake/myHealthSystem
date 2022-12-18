import 'dart:convert';

import 'package:e_health/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_health/models/user.dart' as model;

import '../../components/bottombar.dart';
import '../../resources/auth_methods.dart';
import '../../utils/colors.dart';
import '../../utils/styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nicController.dispose();
    _usernameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().userSignUp(
        email: _emailController.text,
        password: _passwordController.text,
        comfirmPassword: _confirmPasswordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        mobile: _mobileController.text,
        nic: _nicController.text,
        username: _usernameController.text);
    if (res == 'success') {
      model.User userCredentials = await AuthMethods().getUserDetails();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String json = jsonEncode(userCredentials);
      prefs.setString('userCredentials', json);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBar()),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
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
      backgroundColor: CustomColors.bgColor,
      body: Column(
        children: [
          Flexible(
            child: Container(),
          ),
          Container(
            height: 600,
            decoration: BoxDecoration(
                color: CustomColors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registration',
                    style: TextStyles.textHeader1,
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    obscureText: false,
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'First name',
                                      labelStyle: TextStyles.inputlabel,
                                      hintText: 'Enter your first name',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    obscureText: false,
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Last name',
                                      labelStyle: TextStyles.inputlabel,
                                      hintText: 'Enter your last name',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: false,
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Username',
                                  labelStyle: TextStyles.inputlabel,
                                  hintText: 'Enter your username'),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: false,
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Email',
                                  labelStyle: TextStyles.inputlabel,
                                  hintText: 'Enter your email'),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: false,
                              controller: _nicController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'NIC',
                                  labelStyle: TextStyles.inputlabel,
                                  hintText: 'Enter your NIC'),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: false,
                              controller: _mobileController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Mobile',
                                  labelStyle: TextStyles.inputlabel,
                                  hintText: 'Enter your mobile number'),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Password',
                                  labelStyle: TextStyles.inputlabel,
                                  hintText: 'Enter your password'),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: true,
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyles.inputlabel,
                                  hintText: 'Confirm your password'),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: signUp,
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: !_isLoading
                                      ? Text(
                                          "SignUp",
                                          style: TextStyles.regulerText,
                                        )
                                      : CircularProgressIndicator(
                                          color: CustomColors.white,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  },
                                  child: const Text('Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
