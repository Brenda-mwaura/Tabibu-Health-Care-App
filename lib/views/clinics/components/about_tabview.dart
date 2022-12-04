import 'package:flutter/material.dart';

class AboutClinicTabView extends StatelessWidget {
  const AboutClinicTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: const Center(
        child: Text("About clinic"),
      ),
    );
  }
}
