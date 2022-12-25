import 'dart:convert';

import 'package:e_health/resources/api_methods.dart';
import 'package:e_health/screens/add_schedule_screen/components/date_field.dart';
import 'package:e_health/screens/add_schedule_screen/components/doctor_dropdown.dart';
import 'package:e_health/screens/add_schedule_screen/components/hospital_dropdown.dart';
import 'package:e_health/screens/add_schedule_screen/components/time_field.dart';
import 'package:e_health/screens/schedule_screen/schedule_screen.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  String doctorID = '';
  String hospitalID = '';
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay endTime = const TimeOfDay(hour: 8, minute: 00);
  final TextEditingController _discriptionController = TextEditingController();

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

  createAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('userCredentials');
    Map<String, dynamic> userCredentials = jsonDecode(json!);

    if (doctorID == '') {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a doctor'),
      ));
    }

    if (hospitalID == '') {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a hospital'),
      ));
    }

    if (startTime.hour > endTime.hour ||
        (startTime.hour == endTime.hour &&
            startTime.minute >= endTime.minute)) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please start Time cannot be greater than end Time'),
      ));
    }

    await APImethods().createAppointment(
      doctorID: doctorID,
      uid: userCredentials['uid'],
      hospitalID: hospitalID,
      date: selectedDate,
      startTime: startTime,
      endTime: endTime,
      description: _discriptionController.text,
    );
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ScheduleScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Make Appointment',
                    style: TextStyles.textHeader1.copyWith(fontSize: 40),
                  ),
                ],
              ),
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
                        'Start Time :',
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
                    onTap: createAppointment,
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
                          child: Text(
                        "Submit",
                        style: TextStyles.regulerText
                            .copyWith(color: CustomColors.black),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}