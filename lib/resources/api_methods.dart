import 'dart:convert';

import 'package:http/http.dart' as http;

class APImethods {
  static String api = 'https://6b69-175-157-47-229.in.ngrok.io';

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

  Future<List> getSchedulesByID({required int id}) async {
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
}
