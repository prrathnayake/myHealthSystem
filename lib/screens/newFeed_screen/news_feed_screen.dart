import 'package:e_health/resources/auth_methods.dart';
import 'package:e_health/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await AuthMethods().signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: Text(
                      'Medical Updates',
                      style: TextStyles.textHeader1.copyWith(fontSize: 40),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
