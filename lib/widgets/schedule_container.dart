import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/appointment_model.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/widgets/buttons/schedule_button.dart';
import 'package:tabibu/widgets/clinics_widget/schedule_bottom_sheet.dart';

class ScheduleContainer extends StatefulWidget {
  final Appointment appointment;
  ScheduleContainer({Key? key, required this.appointment}) : super(key: key);

  @override
  State<ScheduleContainer> createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);

    await clinicProvider.fetchClinicDetails(widget.appointment.clinic);
    await clinicProvider.getClinicServiceDetails(
        int.parse(widget.appointment.service.toString()));
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
                        value.clinicDetails.clinicName.toString(),
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
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          value.clinicDetails.displayImage.toString(),
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
            height: 15,
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
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    color: Colors.orange,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.appointment.status.toString(),
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
          const SizedBox(
            height: 20,
          ),
          //buttons row
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: ScheduleButton(
                    onPressed: () {},
                    text: "Cancel",
                    fillColor: const Color.fromARGB(255, 244, 246, 250),
                    textColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: RawMaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return ScheduleBottomSheet(
                              title: "Reschedule",
                              formWidget: Form(
                                child: Column(
                                  children: [],
                                ),
                              ),
                            );
                          });
                    },
                    fillColor: Styles.primaryColor,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Reschedule",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
