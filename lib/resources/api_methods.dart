import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class APImethods {
  static String api = 'https://f6f5-175-157-47-229.ap.ngrok.io';

  Future<List> getSchedules() async {
    List schedules;
    http.Response response = await http.get(
      Uri.parse('$api/schedules'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    schedules = jsonDecode(response.body);
    return schedules;
  }

  Future<List> getScheduleByID({required int id}) async {
    List schedules;
    http.Response response = await http.get(
      Uri.parse('$api/schedules/id?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    schedules = jsonDecode(response.body);
    return schedules;
  }

  Future<List> getSchedulesByUserID({required String uid}) async {
    List schedules;
    http.Response response = await http.get(
      Uri.parse('$api/schedules/userid?id=$uid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.body.toString() == '"no details!!"') {
      return schedules = [];
    }

    schedules = jsonDecode(response.body);

    return schedules;
  }

  Future<List> doctorDropdown() async {
    List doctors;
    http.Response response = await http.get(
      Uri.parse('$api/doctors/dropdown'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    doctors = jsonDecode(response.body);
    return doctors;
  }

  Future<List> hospitalDropdown() async {
    List hospitals;
    http.Response response = await http.get(
      Uri.parse('$api/hospitals/dropdown'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    hospitals = jsonDecode(response.body);
    return hospitals;
  }

  Future<void> createAppointment(
      {required String hospitalID,
      required String doctorID,
      required String uid,
      required DateTime date,
      required TimeOfDay startTime,
      required TimeOfDay endTime,
      required String description}) async {
    await http.post(Uri.parse('$api/schedules/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'doctorID': doctorID,
          'patientUid': uid,
          'hospitalID': hospitalID,
          'dateNow': DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(DateTime.now())
              .toString(),
          'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(date).toString(),
          'startTime': DateFormat('HH:mm:ss').format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              startTime.hour,
              startTime.minute)),
          'endTime': DateFormat('HH:mm:ss')
              .format(DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, endTime.hour, endTime.minute))
              .toString(),
          'description': description,
        }));
  }

  Future<void> updateAppointment(
      {required String scheduleID,
      required String hospitalID,
      required String doctorID,
      required String uid,
      required DateTime date,
      required TimeOfDay startTime,
      required TimeOfDay endTime,
      required String description}) async {
    await http.post(Uri.parse('$api/schedules/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'scheduleID': scheduleID,
          'doctorID': doctorID,
          'patientUid': uid,
          'hospitalID': hospitalID,
          'dateNow': DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(DateTime.now())
              .toString(),
          'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(date).toString(),
          'startTime': DateFormat('HH:mm:ss').format(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              startTime.hour,
              startTime.minute)),
          'endTime': DateFormat('HH:mm:ss')
              .format(DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, endTime.hour, endTime.minute))
              .toString(),
          'description': description,
        }));
  }

  Future<void> cancleAppointment({
    required String appointmentID,
  }) async {
    await http.post(
      Uri.parse('$api/schedules/cancle?id=$appointmentID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<void> predicDisease({
    required List symptoms,
  }) async {
    await http.get(
      Uri.parse('$api/?symptoms=$symptoms'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<List> getDoctors() async {
    List doctors;
    http.Response response = await http.get(
      Uri.parse('$api/doctors'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    doctors = jsonDecode(response.body);
    return doctors;
  }

  Future<List> getDoctorsByID({required int id}) async {
    List doctors;
    http.Response response = await http.get(
      Uri.parse('$api/doctors/id?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    doctors = jsonDecode(response.body);
    return doctors;
  }

  Future<List> getHospitals() async {
    List hospitals;
    http.Response response = await http.get(
      Uri.parse('$api/hospitals/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    hospitals = jsonDecode(response.body);
    return hospitals;
  }
}
