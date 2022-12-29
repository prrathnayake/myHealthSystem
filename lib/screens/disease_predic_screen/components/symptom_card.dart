import 'dart:ui';

import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class SymptomCard extends StatefulWidget {
  const SymptomCard(
      {super.key,
      required this.symptom,
      required this.isSelected,
      required this.onSelected});
  final String symptom;
  final bool isSelected;
  final dynamic onSelected;

  @override
  State<SymptomCard> createState() => _SymptomCardState();
}

class _SymptomCardState extends State<SymptomCard> {
  bool selected = false;
  onTap() {
    widget.onSelected(widget.symptom, selected);
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: 100,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            !selected
                ? Text(
                    widget.symptom,
                    style: TextStyles.regulerText
                        .copyWith(color: CustomColors.black, fontSize: 25),
                  )
                : Text(
                    widget.symptom,
                    style: TextStyles.regulerText
                        .copyWith(color: Colors.lightBlue, fontSize: 25),
                  ),
            !selected ? const SizedBox() : const Icon(Icons.done)
          ],
        ),
      ),
    );
  }
}
