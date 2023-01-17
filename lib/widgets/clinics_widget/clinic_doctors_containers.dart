import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_doctor_model.dart';

class DoctorsContainer extends StatelessWidget {
  final ClinicDoctor doctor;
  const DoctorsContainer({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/afya.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            doctor.user!.fullName.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            doctor.specialization.toString(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Icon(
                Icons.call,
                color: Styles.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
