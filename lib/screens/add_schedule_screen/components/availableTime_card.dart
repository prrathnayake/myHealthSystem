import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class AvailableTimeCard extends StatelessWidget {
  const AvailableTimeCard({super.key, required this.availableTime});
  final Map<dynamic, dynamic> availableTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            '${availableTime['dayOfWeek'].toString()} - ',
            style: TextStyles.textHeader1.copyWith(fontSize: 20),
          ),
          Text(
            'at ${availableTime['startTime'].toString()} ',
            style: TextStyles.textHeader1.copyWith(fontSize: 20),
          ),
          Text(
            'to ${availableTime['endTime'].toString()}',
            style: TextStyles.textHeader1.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
