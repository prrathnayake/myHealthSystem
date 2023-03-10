import 'package:e_health/screens/hospital_details_screen/hospital_details_screen.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key, required this.hospital});
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
                Image.asset('assets/images/hospital.jpg'),
                const SizedBox(height: 10),
                Text(
                  ' ${hospital['name']}',
                  style: TextStyles.regulerText,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  ' ${hospital['address']}',
                  style: TextStyle(color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.star),
                    const SizedBox(width: 1),
                    Text(
                      ' ${hospital['rate']}',
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
