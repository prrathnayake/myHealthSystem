import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class ScheduleDetailCard extends StatelessWidget {
  const ScheduleDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Sunil Peris',
                        style: TextStyles.textHeader2,
                      ),
                      Text(
                        'Cardiologist',
                        style: TextStyles.regulerText,
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/doctor.png'),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.event_outlined),
                      Text('31/12/2022')
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.schedule_rounded),
                      Text('10:30AM')
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 10,
                      ),
                      Text('Confirm')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(child: Text('Cancle')),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade400,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                          child: Text(
                        'Reschedule',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
