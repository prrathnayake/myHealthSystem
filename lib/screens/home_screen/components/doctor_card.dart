import 'package:e_health/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});
  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(id: doctor['staffID'])));
      },
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          width: 150,
          height: 200,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/doctor.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Dr. ${doctor['firstName']}  ${doctor['lastName']}',
                  style: TextStyles.regulerText,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  ' ${doctor['area']}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.star),
                    const SizedBox(width: 1),
                    Text(
                      '${doctor['rate']}',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
