import 'package:e_health/screens/add_schedule_screen/components/date_field.dart';
import 'package:e_health/screens/add_schedule_screen/components/doctor_dropdown.dart';
import 'package:e_health/screens/add_schedule_screen/components/hospital_dropdown.dart';
import 'package:e_health/screens/add_schedule_screen/components/time_field.dart';
import 'package:e_health/utils/colors.dart';
import 'package:e_health/utils/styles.dart';
import 'package:flutter/material.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const DoctorDropdown(),
                  const HospitalDropdown(),
                  const DateField(),
                  const TimeField(),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discription :',
                        style: TextStyles.textHeader2
                            .copyWith(color: CustomColors.black),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 230.0,
                        child: TextField(
                          maxLines: 5,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelStyle: TextStyles.inputlabel,
                            hintText: "Enter discription",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
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
