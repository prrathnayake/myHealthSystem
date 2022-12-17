import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/profileImage.jpg'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    'Hi Pasan',
                    style: TextStyles.textHeader1,
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
