import 'package:e_health/utils/styles.dart';
import 'package:flutter/cupertino.dart';

class HorizontalDoctorCard extends StatelessWidget {
  const HorizontalDoctorCard({super.key, required this.doctor});
  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Dr. ${doctor['firstName']}  ${doctor['lastName']}',
        style: TextStyles.regulerText,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
