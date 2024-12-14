//import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String url;
  String flag;
  late String isDay;

  WorldTime(
      {this.location = 'Berlin', this.flag = 'uk.JPG', this.url = 'london'});

  Future<void> getTime() async {
    try {
      http.Response response = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/Europe/$url'));
      String responseBody = response.body;
      Map data = jsonDecode(responseBody);
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(dateTime);
      //print(offset);
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now);
      isDay =  now.hour > 6 && now.hour < 19 ? 'assets/day.JPG':'assets/night.JPG';
      time = DateFormat.jm().format(now); //now.toString();
    } catch (e) {
      time = 'error: $e';
    }
  }
}
