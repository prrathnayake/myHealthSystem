import 'package:e_health/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class HorizontalDoctorCard extends StatelessWidget {
  const HorizontalDoctorCard({super.key, required this.doctor});
  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(id: doctor['staffID'])));
      },
      child: Container(
        child: Text(
          'Dr. ${doctor['firstName']}  ${doctor['lastName']}',
          style: TextStyles.regulerText,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
