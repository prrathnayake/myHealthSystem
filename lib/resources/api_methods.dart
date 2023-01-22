import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class APImethods {
  static String api = 'http://172.105.58.35:3001'; //http://172.105.58.35:3001

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
          'staffID': doctorID,
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
          'staffID': doctorID,
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
      Uri.parse('$api/schedules/cancel?id=$appointmentID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<String> predicDisease({
    required List symptoms,
  }) async {
    String disease;
    http.Response response = await http.get(
      Uri.parse('$api/?symptoms=${jsonEncode(symptoms)}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    disease = jsonDecode(response.body)[0];
    return disease;
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

  Future<List> getTopDoctors() async {
    List doctors;
    http.Response response = await http.get(
      Uri.parse('$api/doctors/top'),
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

  Future<List> getTopHospitals() async {
    List hospitals;
    http.Response response = await http.get(
      Uri.parse('$api/hospitals/top'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    hospitals = jsonDecode(response.body);
    return hospitals;
  }

  Future<List> getAvailableTime(
      {required String doctorID, required String hospitalID}) async {
    List availableTime;
    http.Response response = await http.get(
      Uri.parse(
          '$api/doctors/availableTime?doctorID=$doctorID&hospitalID=$hospitalID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    availableTime = jsonDecode(response.body);
    return availableTime;
  }

  Future<List> getSchedulesByDoctorID(
      {required String doctorID, required DateTime date}) async {
    List availableTime;
    http.Response response = await http.get(
      Uri.parse('$api/schedules/doctorID?doctorID=$doctorID&date=$date'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    availableTime = jsonDecode(response.body);
    return availableTime;
  }

  Future<List> getDoctorByID({required String doctorID}) async {
    List doctors;
    http.Response response = await http.get(
      Uri.parse('$api/doctors/id?id=$doctorID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    doctors = jsonDecode(response.body);
    return doctors;
  }

  Future<List> gethospitalsByID({required String hospitalID}) async {
    List hospitals;
    http.Response response = await http.get(
      Uri.parse('$api/hospitals/id?id=$hospitalID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    hospitals = jsonDecode(response.body);
    return hospitals;
  }

  Future<void> createUserAccount(
      {required String uid,
      required String firstName,
      required String nic,
      required String lastName,
      required String email,
      required String username,
      required String mobile}) async {
    await http.post(Uri.parse('$api/patients/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'uid': uid,
          'firstName': firstName,
          'nic': nic,
          'lastName': lastName,
          'username': username,
          'email': email,
          'mobile': mobile,
        }));
  }
}
