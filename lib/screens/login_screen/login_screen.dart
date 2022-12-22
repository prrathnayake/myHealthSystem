import 'dart:convert';

import 'package:e_health/components/bottombar.dart';
import 'package:e_health/screens/signup_screen/signup_screen.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_health/models/user.dart' as model;

import '../../resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String username = '';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signIn() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().userSignIn(
        email: _emailController.text, password: _passwordController.text);
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
                    'Welcome Back',
                    style: TextStyles.textHeader1,
                  ),
                  const SizedBox(height: 40),
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
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyles.inputlabel,
                        hintText: 'Enter your password'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forget Password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: signIn,
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
                                "Login",
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
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
