import 'package:flutter/material.dart';
import 'package:tabibu/utils/size_utils.dart';

defaultPadding(BuildContext context) {
  return MediaQuery.of(context).size.width /
      100 *
      (Responsive.isTablet(context) ? 3 : (Responsive.isTall(context) ? 4 : 3));
}

double defaultRadius = 11;
const defaultDuration = Duration(seconds: 1);
