import 'dart:math';

import 'package:intl/intl.dart';

class FlightHelpers{

 static String generateFlightNumber() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('ddMMyyyy').format(now);
    return formattedDate;
  }


}