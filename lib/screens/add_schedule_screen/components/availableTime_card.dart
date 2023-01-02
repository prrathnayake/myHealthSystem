import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            'at ${DateFormat('hh:mm a').format(DateTime.parse('${DateTime.now().year}-${DateTime.now().month < 10 ? ('0${DateTime.now().month}') : DateTime.now().month}-${DateTime.now().day < 10 ? ('0${DateTime.now().day}') : DateTime.now().day} ${availableTime['startTime']}'))} ',
            style: TextStyles.textHeader1.copyWith(fontSize: 20),
          ),
          Text(
            'to ${DateFormat('hh:mm a').format(DateTime.parse('${DateTime.now().year}-${DateTime.now().month < 10 ? ('0${DateTime.now().month}') : DateTime.now().month}-${DateTime.now().day < 10 ? ('0${DateTime.now().day}') : DateTime.now().day} ${availableTime['endTime']}'))}',
            style: TextStyles.textHeader1.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
