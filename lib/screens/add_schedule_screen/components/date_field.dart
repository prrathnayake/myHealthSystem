import 'package:e_health/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/styles.dart';

class DateField extends StatefulWidget {
  late DateTime selectedDate;
  final dynamic getFuc;
  DateField({super.key, required this.selectedDate, required this.getFuc});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        keyboardType: TextInputType.datetime,
        context: context,
        initialDate: widget.selectedDate,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
      });
      widget.getFuc(picked);
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
              'Date :',
              style: TextStyles.textHeader2.copyWith(color: CustomColors.black),
            ),
            const SizedBox(width: 20),
            Text(
              DateFormat.yMEd().format(widget.selectedDate).toString(),
              style: TextStyles.textHeader2,
            ),
          ],
        ),
        TextButton(
          onPressed: () => _selectDate(context),
          child: Text(
            'Change date',
            style: TextStyles.textHeader2.copyWith(color: CustomColors.black),
          ),
        ),
      ],
    );
  }
}
