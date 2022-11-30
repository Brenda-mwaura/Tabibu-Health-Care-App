import 'package:flutter/material.dart';

class ClinicScreen extends StatefulWidget {
  ClinicScreen({Key? key}) : super(key: key);

  @override
  State<ClinicScreen> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Clinics...."),
        ),
      ),
    );
  }
}
