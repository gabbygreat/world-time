import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DateTimeInfo {
  final String utcOffset;
  final String timezone;
  final int dayOfWeek;
  final int dayOfYear;
  final String datetime;
  final String utcDatetime;
  final int unixtime;
  final int rawOffset;
  final int weekNumber;
  final bool dst;
  final String abbreviation;
  final int dstOffset;
  final String? dstFrom;
  final String? dstUntil;
  final String clientIp;
  final String isDay;
  final String time;

  DateTimeInfo({
    required this.utcOffset,
    required this.timezone,
    required this.dayOfWeek,
    required this.dayOfYear,
    required this.datetime,
    required this.utcDatetime,
    required this.unixtime,
    required this.rawOffset,
    required this.weekNumber,
    required this.dst,
    required this.abbreviation,
    required this.dstOffset,
    this.dstFrom,
    this.dstUntil,
    required this.clientIp,
    required this.isDay,
    required this.time,
  });

  // Factory constructor to create the object from JSON
  factory DateTimeInfo.fromJson(Map<String, dynamic> json) {
    String dateTime = json['datetime'];
    String offset = json['utc_offset'].substring(1, 3);

    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    final isDayTime =
        now.hour > 6 && now.hour < 19 ? 'assets/day.JPG' : 'assets/night.JPG';

    return DateTimeInfo(
      utcOffset: json['utc_offset'],
      timezone: json['timezone'],
      dayOfWeek: json['day_of_week'],
      dayOfYear: json['day_of_year'],
      datetime: json['datetime'],
      utcDatetime: json['utc_datetime'],
      unixtime: json['unixtime'],
      rawOffset: json['raw_offset'],
      weekNumber: json['week_number'],
      dst: json['dst'],
      abbreviation: json['abbreviation'],
      dstOffset: json['dst_offset'],
      dstFrom: json['dst_from'],
      dstUntil: json['dst_until'],
      clientIp: json['client_ip'],
      isDay: isDayTime,
      time: DateFormat.jm().format(now),
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'utc_offset': utcOffset,
      'timezone': timezone,
      'day_of_week': dayOfWeek,
      'day_of_year': dayOfYear,
      'datetime': datetime,
      'utc_datetime': utcDatetime,
      'unixtime': unixtime,
      'raw_offset': rawOffset,
      'week_number': weekNumber,
      'dst': dst,
      'abbreviation': abbreviation,
      'dst_offset': dstOffset,
      'dst_from': dstFrom,
      'dst_until': dstUntil,
      'client_ip': clientIp,
      'is_day': isDay,
      'time': time,
    };
  }
}

class NetworkRequest {
  static String baseUrl = 'https://worldtimeapi.org/api';

  static Future<List<String>> fetchTimeZones() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/timezone'));
    String responseBody = response.body;
    final data = jsonDecode(responseBody);
    return (data as List).map((e) => '$e').toList();
  }

  static Future<DateTimeInfo> fetchTime({required String timezone}) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/timezone/$timezone'),
    );
    String responseBody = response.body;
    final data = jsonDecode(responseBody);
    return DateTimeInfo.fromJson(data);
  }

  static Future<DateTimeInfo> fetchInitialTime() async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/timezone/Europe/London'),
    );
    String responseBody = response.body;
    final data = jsonDecode(responseBody);
    return DateTimeInfo.fromJson(data);
  }
}
