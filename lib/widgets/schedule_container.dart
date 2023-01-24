import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/appointment_model.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/data/models/services.dart';
import 'package:tabibu/providers/appointment_provider.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/buttons/schedule_button.dart';
import 'package:tabibu/widgets/clinics_widget/schedule_bottom_sheet.dart';
import 'package:tabibu/widgets/spinner.dart';

class ScheduleContainer extends StatefulWidget {
  final Appointment appointment;
  final Clinic clinic;
  final ClinicServices service;

  ScheduleContainer(
      {Key? key,
      required this.appointment,
      required this.clinic,
      required this.service})
      : super(key: key);

  @override
  State<ScheduleContainer> createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  GlobalKey<FormState> updateAppointmentFormKey = GlobalKey<FormState>();
  TextEditingController _updateAppointmentDateTextController =
      TextEditingController();
  TextEditingController _updateAppointmentTimeTextController =
      TextEditingController();

  Future _updateAppointmentDate(BuildContext context, DateTime initDate) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(
        2015,
      ),
      lastDate: DateTime(2101),
    );

    if (selected != null) {
      setState(() {
        _updateAppointmentDateTextController.text =
            DateFormat('dd-MM-yyyy').format(selected);
        setState() {
          _updateAppointmentDateTextController.text =
              DateFormat('dd-MM-yyyy').format(selected);
        }
      });
    }
  }

  Future _updateAppointmentTime(
      BuildContext context, TimeOfDay initTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _updateAppointmentTimeTextController.text = picked.format(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
            offset: const Offset(0, 3),
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
                            widget.service.serviceName.toString(),
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
                      ? Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
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
                    onPressed: () async {
                      var appointmentProvider =
                          Provider.of<AppointmentProvider>(context,
                              listen: false);

                      await appointmentProvider.fetchAppointmentDetails(
                          int.parse(widget.appointment.id.toString()));

                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return ScheduleBottomSheet(
                              initialHeight: 0.54,
                              title: "Reschedule",
                              formWidget: Consumer<AppointmentProvider>(
                                builder: (context, value, child) {
                                  if (value.appointmentDetailsLoading == true) {
                                    return const Center(
                                      child: AppSpinner(),
                                    );
                                  } else {
                                    _updateAppointmentDateTextController.text =
                                        DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(value
                                                .appointmentDetails
                                                .appointmentDate
                                                .toString()));

                                    _updateAppointmentTimeTextController
                                        .text = DateFormat(
                                            'hh:mm a')
                                        .format(DateTime.parse(
                                            "2022-10-15 ${value.appointmentDetails.appointmentTime}"));

                                    return Form(
                                      key: updateAppointmentFormKey,
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 106, 106, 106),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            controller:
                                                _updateAppointmentDateTextController,
                                            autofocus: false,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              fillColor: const Color.fromARGB(
                                                  255, 245, 170, 51),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 20, 106, 218),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              prefixIcon: const Icon(
                                                  Icons.calendar_month),
                                            ),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 106, 106, 106),
                                            ),
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime initDate =
                                                  DateTime.parse(value
                                                      .appointmentDetails
                                                      .appointmentDate
                                                      .toString());
                                              _updateAppointmentDate(
                                                  context, initDate);
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please select date";
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Time",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 106, 106, 106),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            controller:
                                                _updateAppointmentTimeTextController,
                                            autofocus: false,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              fillColor: const Color.fromARGB(
                                                  255, 245, 170, 51),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 20, 106, 218),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              prefixIcon:
                                                  const Icon(Icons.access_time),
                                            ),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 106, 106, 106),
                                            ),
                                            readOnly: true,
                                            onTap: () async {},
                                            validator: (value) {
                                              //validate to prevent empty field
                                              if (value!.isEmpty) {
                                                return "Please select time";
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          AuthButton(
                                            onPressed: () {},
                                            child:
                                                Consumer<AppointmentProvider>(
                                              builder: (context, value, child) {
                                                return const Text(
                                                  "Reschedule",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
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
