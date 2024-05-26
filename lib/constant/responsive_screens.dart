import 'package:flutter/cupertino.dart';

class ResponsiveConstants {

  static int calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 2; // Small screen
    } else if (screenWidth < 900) {
      return 3; // Medium screen
    } else {
      return 4; // Large screen
    }
  }
}