import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/data/models/appointment_model.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/appointment_provider.dart';
import 'package:tabibu/providers/clinic_provider.dart';

class CancelledAppointmentContainer extends StatefulWidget {
  final Color statusColor;
  final String status;
  final Appointment appointment;
  final Clinic clinic;

  CancelledAppointmentContainer(
      {Key? key,
      required this.statusColor,
      required this.status,
      required this.appointment,
      required this.clinic})
      : super(key: key);

  @override
  State<CancelledAppointmentContainer> createState() =>
      _CancelledAppointmentContainerState();
}

class _CancelledAppointmentContainerState
    extends State<CancelledAppointmentContainer> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    await clinicProvider.fetchClinics();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 25,
        left: 10,
        top: 10,
        right: 10,
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
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
      child: Column(
        children: [
          Consumer<ClinicProvider>(
            builder: (context, value, child) {
              return Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.clinic.clinicName.toString(),
                        // value.clinicDetails.clinicName.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Consumer<ClinicProvider>(
                        builder: (context, serviceValue, child) {
                          return Text(
                            serviceValue.serviceDetails.serviceName.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  widget.clinic.displayImage == null
                      // value.clinicDetails.displayImage == null
                      ? Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.clinic.displayImage.toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            color: Color.fromARGB(255, 199, 199, 199),
            thickness: 0.5,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(221, 69, 69, 69),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(
                          widget.appointment.appointmentDate.toString(),
                        ))
                        .toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(221, 69, 69, 69),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Color.fromARGB(221, 69, 69, 69),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat('hh:mm a').format(DateTime.parse(
                        "2022-10-15 ${widget.appointment.appointmentTime}")),
                    style: const TextStyle(
                      color: Color.fromARGB(221, 69, 69, 69),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // confirmed green dot
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: widget.statusColor,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.status,
                    style: const TextStyle(
                      color: Color.fromARGB(221, 69, 69, 69),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
