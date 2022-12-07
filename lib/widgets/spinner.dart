import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // make a circular progress indicator
    return const Center(
      child: CircularProgressIndicator(
        color: Styles.primaryColor,
        strokeWidth: 2.0,
      ),
    );
  }
}
