import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_doctor_model.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsContainer extends StatefulWidget {
  final ClinicDoctor doctor;
  DoctorsContainer({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorsContainer> createState() => _DoctorsContainerState();
}

class _DoctorsContainerState extends State<DoctorsContainer> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    await clinicProvider.getDoctorSpecialization(widget.doctor.specialization);
  }

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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(widget.doctor.profilePicture.toString()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(widget.doctor.user!.fullName.toString(),
              style: Styles.normal(context,
                  fontColor: Colors.black, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 5,
          ),
          Consumer<ClinicProvider>(
            builder: (context, value, child) {
              return Text(
                value.doctorSpecialization.specialization.toString(),
                style: Styles.custom18(context,fontWeight: FontWeight.w500,fontColor: Colors.grey)
                
              );
            },
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () async {
              await _launchCaller(widget.doctor.user!.phone.toString());
            },
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
                    offset: const Offset(0, 3),
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

  Future _launchCaller(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: "tel",
      path: phoneNumber,
    );
    await launchUrl(phoneLaunchUri);
  }
}
