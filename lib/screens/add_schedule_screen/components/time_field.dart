import 'package:e_health/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/styles.dart';

class TimeField extends StatefulWidget {
  late TimeOfDay selectedTime;
  final dynamic getFuc;
  TimeField({super.key, required this.selectedTime, required this.getFuc});

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 00),
    );
    if (picked != null && picked != widget.selectedTime) {
      setState(() {
        widget.selectedTime = picked;
      });
      widget.getFuc(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('hh:mm a').format(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                widget.selectedTime.hour,
                widget.selectedTime.minute)),
            style: TextStyles.textHeader2,
          ),
          TextButton(
            onPressed: () => _selectTime(context),
            child: Text(
              'Change time',
              style: TextStyles.textHeader2.copyWith(color: CustomColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
