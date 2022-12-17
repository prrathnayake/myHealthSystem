import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          'Schedule',
          style: TextStyles.textHeader1.copyWith(fontSize: 40),
        ),
      ),
    );
  }
}
