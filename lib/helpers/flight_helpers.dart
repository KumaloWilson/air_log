import 'dart:math';

import 'package:intl/intl.dart';

class FlightHelpers{

 static String generateFlightNumber() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('ddMMyyyy').format(now);
    return formattedDate;
  }


 static String getTodayDateString() {
   final DateTime now = DateTime.now();
   return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
 }

}