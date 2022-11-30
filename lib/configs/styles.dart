import 'package:flutter/material.dart';
import 'package:tabibu/utils/size_utils.dart';

class Styles {
  static const Color primaryColor = Color.fromARGB(255, 226, 35, 26);
  static const Color secondaryColor = Color.fromARGB(255, 255, 255, 255);

  // headings
  static TextStyle heading2(BuildContext context) {
    return TextStyle(
        color: Colors.white,
        fontSize: Responsive.isTablet(context)
            ? 27
            : (Responsive.isTall(context) ? 22 : 20),
        fontWeight: FontWeight.bold);
  }

  static TextStyle normalText(BuildContext context) {
    return TextStyle(
      color: Colors.black87.withOpacity(0.7),
      fontWeight: FontWeight.normal,
      fontSize: Responsive.isTablet(context) ? 22 : 17,
    );
  }
}
