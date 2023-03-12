import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/data/models/services.dart';
import 'package:tabibu/providers/appointment_provider.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/widgets/schedule_container.dart';
import 'package:tabibu/widgets/spinner.dart';

class UpcomingAppointmentTabView extends StatefulWidget {
  UpcomingAppointmentTabView({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointmentTabView> createState() =>
      _UpcomingAppointmentTabViewState();
}

class _UpcomingAppointmentTabViewState
    extends State<UpcomingAppointmentTabView> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    await appointmentProvider.fetchUpcomingAppointment();

    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    await clinicProvider.fetchClinics();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (context, position) {
        return SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: Consumer<AppointmentProvider>(
              builder: (context, value, child) {
                return Consumer<ClinicProvider>(
                  builder: (context, clinicValue, child) {
                    //get appointment clinic
                    Clinic nearestUpcomingAppointmentClinic = Clinic();

                    if (value.nearestUpcomingAppointment.clinic != null) {
                      nearestUpcomingAppointmentClinic =
                          clinicValue.clinics.firstWhere(
                        (clinic) =>
                            clinic.id ==
                            int.parse(value.nearestUpcomingAppointment.clinic
                                .toString()),
                        orElse: () => Clinic(),
                      );
                    }

                    //get appointment service
                    ClinicServices nearestUpcomingAppointmentClinicService =
                        ClinicServices();

                    if (value.nearestUpcomingAppointment.service != null) {
                      nearestUpcomingAppointmentClinicService =
                          clinicValue.clinicServices.firstWhere(
                        (service) =>
                            service.id ==
                            int.parse(value.nearestUpcomingAppointment.service
                                .toString()),
                        orElse: () => ClinicServices(),
                      );
                    }
                    if (value.upcomingAppointmentsLoading == true ||
                        clinicValue.servicesLoading == true ||
                        clinicValue.clinicsLoading == true) {
                      return const Center(child: AppSpinner());
                    } else {
                      return value.nearestUpcomingAppointment.id == null &&
                              value.upcomingAppointment.isEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 200,
                              child: SvgPicture.asset(
                                "assets/images/no_future_appointment.svg",
                                fit: BoxFit.contain,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                 Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Nearest visit",
                                    style: Styles.custom20(context,fontWeight: FontWeight.bold),
                                    
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                value.nearestUpcomingAppointment.id != null
                                    ? ScheduleContainer(
                                        service:
                                            nearestUpcomingAppointmentClinicService,
                                        clinic:
                                            nearestUpcomingAppointmentClinic,
                                        appointment:
                                            value.nearestUpcomingAppointment,
                                      )
                                    : const SizedBox(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Future visits",
                                    style: Styles.custom20(context,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Consumer<AppointmentProvider>(
                                  builder: (context, value, child) {
                                    return value.upcomingAppointment.isEmpty
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            height: 200,
                                            child: SvgPicture.asset(
                                              "assets/images/no_future_appointment.svg",
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: value
                                                .upcomingAppointment.length,
                                            itemBuilder: (context, index) {
                                              if (clinicValue.clinicsLoading ==
                                                      true ||
                                                  clinicValue.servicesLoading ==
                                                      true) {
                                                return const SizedBox();
                                              } else {
                                                Clinic clinic = Clinic();
                                                // appointment clinic
                                                if (value
                                                        .upcomingAppointment[
                                                            index]
                                                        .clinic !=
                                                    null) {
                                                  clinic = clinicValue.clinics
                                                      .firstWhere((clinic) =>
                                                          clinic.id ==
                                                          int.parse(value
                                                              .upcomingAppointment[
                                                                  index]
                                                              .clinic
                                                              .toString()));
                                                }

                                                // clinic service
                                                ClinicServices service =
                                                    ClinicServices();
                                                if (value
                                                        .upcomingAppointment[
                                                            index]
                                                        .service !=
                                                    null) {
                                                  service = clinicValue
                                                      .clinicServices
                                                      .firstWhere((service) =>
                                                          service.id ==
                                                          int.parse(value
                                                              .upcomingAppointment[
                                                                  index]
                                                              .service
                                                              .toString()));
                                                }

                                                return ScheduleContainer(
                                                    service: service,
                                                    clinic: clinic,
                                                    appointment: value
                                                            .upcomingAppointment[
                                                        index]);
                                              }
                                            },
                                          );
                                  },
                                ),
                              ],
                            );
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
