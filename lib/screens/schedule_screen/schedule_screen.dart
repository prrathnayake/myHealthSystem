import 'package:e_health/screens/schedule_screen/components/schedule_detail_card.dart';
import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schedule',
              style: TextStyles.textHeader1.copyWith(fontSize: 40),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    ScheduleDetailCard(),
                    ScheduleDetailCard(),
                    ScheduleDetailCard(),
                    ScheduleDetailCard()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
