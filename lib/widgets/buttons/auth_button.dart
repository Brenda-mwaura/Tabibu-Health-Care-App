import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';

class AuthButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  const AuthButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RawMaterialButton(
        onPressed: () {
          onPressed();
        },
        fillColor: Styles.primaryColor,
        elevation: 5,
        padding: const EdgeInsets.symmetric(
          vertical: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
