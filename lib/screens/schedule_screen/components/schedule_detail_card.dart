import 'package:e_health/components/CustomStackBar.dart';
import 'package:e_health/components/bottombar.dart';
import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/reschedule_screen.dart/reschedule_screen.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDetailCard extends StatefulWidget {
  const ScheduleDetailCard({super.key, required this.schedule});
  final Map<dynamic, dynamic> schedule;

  @override
  State<ScheduleDetailCard> createState() => _ScheduleDetailCardState();
}

class _ScheduleDetailCardState extends State<ScheduleDetailCard> {
  cancleAppointment() async {
    await APImethods().cancleAppointment(
        appointmentID: widget.schedule['scheduleID'].toString());
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const BottomBar(
              passIndex: 2,
            )));
  }

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
                        'Dr. ${widget.schedule['firstName']} ${widget.schedule['lastName']}',
                        style: TextStyles.textHeader2,
                      ),
                      Text(
                        '${widget.schedule['discription']}',
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
                      Text(DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(widget.schedule['appointmentDate'])
                              .toLocal()))
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded),
                      const SizedBox(width: 5),
                      Text(DateFormat('hh:mm a').format(DateTime.parse(
                          '${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.schedule['appointmentDate']))}T${widget.schedule['startTime']}.000Z')))
                    ],
                  ),
                  Row(
                    children: [
                      widget.schedule['status'] == 'Confirm'
                          ? const Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 10,
                            )
                          : widget.schedule['status'] == 'Pending'
                              ? const Icon(
                                  Icons.circle,
                                  color: Colors.yellow,
                                  size: 10,
                                )
                              : const Icon(Icons.circle,
                                  color: Colors.red, size: 10),
                      const SizedBox(width: 5),
                      Text('${widget.schedule['status']}')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: widget.schedule['status'] == 'Cancelled'
                        ? () {
                            customStackBar(
                                context: context,
                                text: 'You appointment is already cancelled');
                          }
                        : () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: const Text(
                                    'Are you sure, Do you want to cancel this appointment?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                      onPressed: cancleAppointment,
                                      child: const Text('Sure')),
                                ],
                              ),
                            ),
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
                    onTap: widget.schedule['status'] == 'Canclled'
                        ? () {
                            customStackBar(
                                context: context,
                                text:
                                    'This appointment is cancelled. You cannot reschedule this.');
                          }
                        : () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RescheduleScreen(
                                      scheduleID: widget.schedule['scheduleID'],
                                    )));
                          },
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
