import 'package:flutter/material.dart';
import 'package:tabibu/utils/size_utils.dart';

class Styles {
  static const Color primaryColor = Color.fromARGB(255, 226, 35, 26);
  static const Color secondaryColor = Color.fromARGB(255, 255, 255, 255);

  // headings
  static TextStyle heading1(BuildContext context) {
    return TextStyle(
      color: Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 30
          : Responsive.isMobileLarge(context)
              ? 24
              : 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle heading2(BuildContext context) {
    return TextStyle(
      color: Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 25
          : Responsive.isMobileLarge(context)
              ? 22
              : 19,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle heading3(BuildContext context) {
    return TextStyle(
      color: Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 20
          : Responsive.isMobileLarge(context)
              ? 17
              : 14,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle heading4(BuildContext context) {
    return TextStyle(
      color: Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 15
          : Responsive.isMobileLarge(context)
              ? 12
              : 9,
      fontWeight: FontWeight.w700,
    );
  }

  //body text
  static TextStyle bodyText1(BuildContext context) {
    return TextStyle(
      color: Colors.grey,
      fontSize: Responsive.isTablet(context)
          ? 22
          : Responsive.isMobileLarge(context)
              ? 16
              : 16,
      fontWeight: FontWeight.w400,
    );
  }

  //welcome screen text
  static TextStyle welcomeText(BuildContext context) {
    return TextStyle(
      color: Styles.primaryColor,
      fontSize: Responsive.isTablet(context)
          ? 24
          : Responsive.isMobileLarge(context)
              ? 20
              : 20,
      fontWeight: FontWeight.w400,
    );
  }
}
