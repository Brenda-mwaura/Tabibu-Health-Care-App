import 'package:flutter/material.dart';
import 'package:tabibu/utils/size_utils.dart';

class Styles {
  static const Color primaryColor = Color.fromARGB(255, 226, 35, 26);
  static const Color secondaryColor = Color.fromARGB(255, 255, 255, 255);

    static TextStyle heading1(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 30
          : (Responsive.isMobileLarge(context) ? 25 : 22),
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  static TextStyle heading2(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 27
          : (Responsive.isMobileLarge(context) ? 22 : 20),
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  static TextStyle normal(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 20
          : (Responsive.isMobileLarge(context) ? 18 : 16),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle small(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 16
          : (Responsive.isMobileLarge(context) ? 14 : 12),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle custom25(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 25
          : (Responsive.isMobileLarge(context) ? 22 : 20),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
  static TextStyle custom20(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 24 // set font size to 24 for tablets
          : (Responsive.isMobileLarge(context) ? 20 : 14),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
      }

  static TextStyle custom18(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 18
          : (Responsive.isMobileLarge(context) ? 16 : 14),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle custom12(BuildContext context,
      {Color? fontColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: fontColor ?? Colors.black,
      fontSize: Responsive.isTablet(context)
          ? 16
          : (Responsive.isMobileLarge(context) ? 12 : 10),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }


  // headings
  // static TextStyle heading1(BuildContext context) {
  //   return TextStyle(
  //     color: Colors.black,
  //     fontSize: Responsive.isTablet(context)
  //         ? 30
  //         : Responsive.isMobileLarge(context)
  //             ? 24
  //             : 24,
  //     fontWeight: FontWeight.bold,
  //   );
  // }

  // static TextStyle heading2(BuildContext context) {
  //   return TextStyle(
  //     color: Colors.white,
  //     fontSize: Responsive.isTablet(context)
  //         ? 28
  //         : Responsive.isMobileLarge(context)
  //             ? 25
  //             : 25,
  //     fontWeight: FontWeight.w700,
  //   );
  // }

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
