import 'dart:convert';

import 'package:e_health/components/CustomStackBar.dart';
import 'package:e_health/components/bottombar.dart';
import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/add_schedule_screen/components/availableTime_card.dart';
import 'package:e_health/screens/add_schedule_screen/components/date_field.dart';
import 'package:e_health/screens/add_schedule_screen/components/doctor_dropdown.dart';
import 'package:e_health/screens/add_schedule_screen/components/hospital_dropdown.dart';
import 'package:e_health/screens/add_schedule_screen/components/time_field.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RescheduleScreen extends StatefulWidget {
  const RescheduleScreen({super.key, required this.scheduleID});
  final int scheduleID;

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  List? availableTime;
  List? schedule;
  bool isLoading = false;
  String doctorID = '';
  String hospitalID = '';
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay endTime = const TimeOfDay(hour: 8, minute: 00);
  final TextEditingController _discriptionController = TextEditingController();

  getScheduleData() async {
    setState(() {
      isLoading = true;
    });
    List data = await APImethods().getScheduleByID(id: widget.scheduleID);

    setState(() {
      schedule = data;
      doctorID = data[0]['staffID'].toString();
      hospitalID = data[0]['hospitalID'].toString();
      selectedDate = DateTime.parse(data[0]['appointmentDate']).toLocal();
      startTime = TimeOfDay.fromDateTime(DateTime.parse(
          '${DateFormat('yyyy-MM-dd').format(DateTime.parse(data[0]['appointmentDate']))}T${data[0]['startTime']}.000Z'));
      endTime = TimeOfDay.fromDateTime(DateTime.parse(
          '${DateFormat('yyyy-MM-dd').format(DateTime.parse(data[0]['appointmentDate']))}T${data[0]['endTime']}.000Z'));
      _discriptionController.text = data[0]['description'].toString();
      isLoading = false;
    });
  }

  @override
  void initState() {
    getScheduleData();
    super.initState();
  }

  void refreshDoctorID(String getDoctorID) {
    setState(() {
      doctorID = getDoctorID;
    });
  }

  void refreshHospitalID(String getHospitalID) {
    setState(() {
      hospitalID = getHospitalID;
    });
  }

  void refreshSelectedDate(DateTime getSelectedDate) {
    setState(() {
      selectedDate = getSelectedDate;
    });
  }

  void refreshStartTime(TimeOfDay getStartDate) {
    setState(() {
      startTime = getStartDate;
    });
  }

  void refreshEndTime(TimeOfDay getEndDate) {
    setState(() {
      endTime = getEndDate;
    });
  }

  updateAppointment() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('userCredentials');
    Map<String, dynamic> userCredentials = jsonDecode(json!);

    if (doctorID == '') {
      setState(() {
        isLoading = false;
      });
      return customStackBar(context: context, text: 'Please select a doctor');
    }

    if (hospitalID == '') {
      setState(() {
        isLoading = false;
      });
      return customStackBar(context: context, text: 'Please select a hospital');
    }

    bool dayMatched = false;
    for (var day in availableTime!) {
      if (DateFormat('EEEE').format(selectedDate) == day['dayOfWeek']) {
        dayMatched = true;
        TimeOfDay st = startTime;
        TimeOfDay et = endTime;
        final now = DateTime.now();

        DateTime startDateTime =
            DateTime(now.year, now.month, now.day, st.hour, st.minute);
        DateTime endDateTime =
            DateTime(now.year, now.month, now.day, et.hour, et.minute);
        DateTime availableStartDateTime = DateTime.parse(
            '${now.year}-${now.month < 10 ? ('0${now.month}') : now.month}-${now.day < 10 ? ('0${now.day}') : now.day} ${day['startTime']}');
        DateTime availableEndDateTime = DateTime.parse(
            '${now.year}-${now.month < 10 ? ('0${now.month}') : now.month}-${now.day < 10 ? ('0${now.day}') : now.day} ${day['endTime']}');

        if (startDateTime.hour < availableStartDateTime.hour ||
            endDateTime.hour > availableEndDateTime.hour ||
            (startDateTime.hour == availableStartDateTime.hour &&
                startDateTime.minute < availableStartDateTime.minute) ||
            (endDateTime.hour == availableEndDateTime.hour &&
                endDateTime.minute > availableEndDateTime.minute)) {
          setState(() {
            isLoading = false;
          });
          return customStackBar(
              context: context,
              text:
                  'Doctor only available at ${DateFormat('hh:mm a').format(availableStartDateTime)} to ${DateFormat('hh:mm a').format(availableEndDateTime)}');
        }
      }
    }

    if (!dayMatched) {
      setState(() {
        isLoading = false;
      });
      return customStackBar(
          context: context,
          text:
              'Doctor doesn\'t available in ${DateFormat('EEEE').format(selectedDate)}');
    }

    if (startTime.hour > endTime.hour ||
        (startTime.hour == endTime.hour &&
            startTime.minute >= endTime.minute)) {
      setState(() {
        isLoading = false;
      });
      return customStackBar(
          context: context, text: 'End time cannot be before start time');
    }

    // schedules = getDoctorSchedules(selectedDate);

    // for (var schedule in schedules!) {
    //   TimeOfDay st = startTime;
    //   TimeOfDay et = endTime;
    //   final now = DateTime.now();

    //   DateTime startDateTime =
    //       DateTime(now.year, now.month, now.day, st.hour, st.minute);
    //   DateTime endDateTime =
    //       DateTime(now.year, now.month, now.day, et.hour, et.minute);
    //   DateTime availableStartDateTime = DateTime.parse(
    //       '${now.year}-${now.month < 10 ? ('0${now.month}') : now.month}-${now.day < 10 ? ('0${now.day}') : now.day} ${schedule['startTime']}');
    //   DateTime availableEndDateTime = DateTime.parse(
    //       '${now.year}-${now.month < 10 ? ('0${now.month}') : now.month}-${now.day < 10 ? ('0${now.day}') : now.day} ${schedule['endTime']}');
    // }

    await APImethods().updateAppointment(
      scheduleID: widget.scheduleID.toString(),
      doctorID: doctorID,
      uid: userCredentials['uid'],
      hospitalID: hospitalID,
      date: selectedDate,
      startTime: startTime,
      endTime: endTime,
      description: _discriptionController.text,
    );
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const BottomBar(
              passIndex: 2,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (doctorID != '' && hospitalID != '') {
      getAvailableTime() async {
        List time = await APImethods()
            .getAvailableTime(doctorID: doctorID, hospitalID: hospitalID);

        setState(() {
          availableTime = time;
        });
      }

      getAvailableTime();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: !isLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rescheduling ',
                            style:
                                TextStyles.textHeader1.copyWith(fontSize: 40),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            DoctorDropdown(
                              doctorID: doctorID,
                              getFuc: refreshDoctorID,
                            ),
                            HospitalDropdown(
                              hospitalID: hospitalID,
                              getFuc: refreshHospitalID,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      CustomColors.black, // red as border color
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Doctor Availablity',
                                    style: TextStyles.textHeader1
                                        .copyWith(fontSize: 20),
                                  ),
                                  availableTime != null
                                      ? availableTime!.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: availableTime!
                                                  .map((i) => Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            AvailableTimeCard(
                                                                availableTime:
                                                                    i)
                                                          ]))
                                                  .toList())
                                          : const SizedBox(
                                              child: Text('No available time'),
                                            )
                                      : const SizedBox(
                                          child: Text(
                                              'Please select a doctor and a hospital'),
                                        ),
                                ],
                              ),
                            ),
                            DateField(
                              selectedDate: selectedDate,
                              getFuc: refreshSelectedDate,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Start Time :',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                ),
                                const SizedBox(width: 20),
                                TimeField(
                                  selectedTime: startTime,
                                  getFuc: refreshStartTime,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'End Time :',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                ),
                                const SizedBox(width: 20),
                                TimeField(
                                  selectedTime: endTime,
                                  getFuc: refreshEndTime,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description :',
                                  style: TextStyles.textHeader2
                                      .copyWith(color: CustomColors.black),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 230.0,
                                  child: TextField(
                                    controller: _discriptionController,
                                    maxLines: 5,
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelStyle: TextStyles.inputlabel,
                                      hintText: "Enter description",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: updateAppointment,
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: isLoading
                                      ? CircularProgressIndicator(
                                          color: CustomColors.white,
                                        )
                                      : Text(
                                          "Submit",
                                          style: TextStyles.regulerText
                                              .copyWith(
                                                  color: CustomColors.black),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
