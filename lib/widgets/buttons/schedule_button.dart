import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class ScheduleButton extends StatelessWidget {
  final String text;
  final Color fillColor;
  final Color textColor;
  final Function onPressed;
  const ScheduleButton({
    Key? key,
    required this.text,
    required this.fillColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed(),
      fillColor: fillColor,
      elevation: 5,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: Styles.custom18(context,fontColor: textColor,fontWeight: FontWeight.w500),
      ),
    );
  }
}
