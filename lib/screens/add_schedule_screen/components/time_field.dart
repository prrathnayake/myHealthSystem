import 'package:e_health/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/styles.dart';

class TimeField extends StatefulWidget {
  const TimeField({super.key});

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 00);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 00),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Start Time :',
              style: TextStyles.textHeader2.copyWith(color: CustomColors.black),
            ),
            const SizedBox(width: 20),
            Text(
              DateFormat('hh:mm a').format(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  selectedTime.hour,
                  selectedTime.minute)),
              style: TextStyles.textHeader2,
            ),
          ],
        ),
        TextButton(
          onPressed: () => _selectTime(context),
          child: Text(
            'Change time',
            style: TextStyles.textHeader2.copyWith(color: CustomColors.black),
          ),
        ),
      ],
    );
  }
}
