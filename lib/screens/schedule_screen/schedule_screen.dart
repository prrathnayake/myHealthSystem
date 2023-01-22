import 'dart:convert';

import 'package:e_health/screens/add_schedule_screen/add_schedule_screen.dart';
import 'package:e_health/screens/schedule_screen/components/schedule_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../resources/api_methods.dart';
import '../../utils/styles.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List? schedules;
  bool isLoading = false;

  getSchedules() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('userCredentials');
    Map<String, dynamic> userCredentials = jsonDecode(json!);
    List data = await APImethods()
        .getSchedulesByUserID(uid: userCredentials['uid'].toString());

    setState(() {
      schedules = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appointments',
                style: TextStyles.textHeader1.copyWith(fontSize: 40),
              ),
              const SizedBox(height: 20),
              Text(
                'Upcoming appointments',
                style: TextStyles.textHeader1.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: schedules == null
                    ? const Center(child: CircularProgressIndicator())
                    : schedules!.isNotEmpty
                        ? ListView.builder(
                            itemCount: schedules!.length,
                            itemBuilder: (context, index) {
                              Map<dynamic, dynamic> schedule =
                                  schedules![index];
                              return ScheduleDetailCard(
                                schedule: schedule,
                              );
                            },
                          )
                        : const Center(child: Text('No Schedules')),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddScheduleScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
