import 'dart:convert';

import 'package:e_health/models/schedule.dart';
import 'package:http/http.dart' as http;

class APImethods {
  static String api = 'https://101a-175-157-47-229.in.ngrok.io';

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

  Future<String> getSchedulesByID(int id) async {
    http.Response response = await http.get(
      Uri.parse('$api/schedules/id?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return jsonDecode(response.body);
  }
}
