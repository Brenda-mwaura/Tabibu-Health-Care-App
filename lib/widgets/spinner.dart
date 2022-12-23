import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class AppSpinner extends StatelessWidget {
  //color
  final Color? color;
  const AppSpinner({
    Key? key,
    this.color = Styles.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        // Styles.primaryColor,
        strokeWidth: 3.0,
      ),
    );
  }
}
