import 'package:e_health/screens/hospital_details_screen/hospital_details_screen.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class HorizontalHospitalCard extends StatelessWidget {
  const HorizontalHospitalCard({super.key, required this.hospital});
  final Map<dynamic, dynamic> hospital;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HospitalDetailsScreen(id: hospital['hospitalID'])));
      },
      child: Container(
        child: Text(
          '${hospital['name']}',
          style: TextStyles.regulerText,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
