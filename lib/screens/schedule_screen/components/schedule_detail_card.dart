import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDetailCard extends StatelessWidget {
  const ScheduleDetailCard({super.key, required this.schedule});
  final Map<dynamic, dynamic> schedule;

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
                        'Dr. ${schedule['firstName']} ${schedule['lastName']}',
                        style: TextStyles.textHeader2,
                      ),
                      Text(
                        '${schedule['area']}',
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
                    children: [
                      const Icon(Icons.event_outlined),
                      const SizedBox(width: 5),
                      Text(DateFormat.yMEd()
                          .format(DateTime.parse(schedule['appointmentDate'])))
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded),
                      const SizedBox(width: 5),
                      Text(DateFormat('hh:mm a').format(DateTime.parse(
                          '${DateFormat('yyyy-MM-dd').format(DateTime.parse(schedule['appointmentDate']))}T${schedule['startTime']}.000Z')))
                    ],
                  ),
                  Row(
                    children: [
                      schedule['status'] == 'Confirm'
                          ? const Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 10,
                            )
                          : schedule['status'] == 'Pending'
                              ? const Icon(
                                  Icons.circle,
                                  color: Colors.yellow,
                                  size: 10,
                                )
                              : const Icon(Icons.circle,
                                  color: Colors.red, size: 10),
                      const SizedBox(width: 5),
                      Text('${schedule['status']}')
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
