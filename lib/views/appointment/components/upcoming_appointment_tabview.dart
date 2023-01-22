import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
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
    var clinicProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    await clinicProvider.fetchUpcomingAppointment();
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
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nearest visit",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              value.upcomingAppointmentsLoading == true
                                  ? AppSpinner()
                                  : value.nearestUpcomingAppointment.id == null
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          height: 200,
                                          child: SvgPicture.asset(
                                            "assets/images/no_future_appointment.svg",
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      : ScheduleContainer(
                                          appointment:
                                              value.nearestUpcomingAppointment,
                                        ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Future visits",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Consumer<AppointmentProvider>(
                                builder: (context, value, child) {
                                  if (value.upcomingAppointmentsLoading ==
                                      true) {
                                    return AppSpinner();
                                  } else {
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
                                              return ScheduleContainer(
                                                  appointment:
                                                      value.upcomingAppointment[
                                                          index]);
                                            },
                                          );
                                  }
                                },
                              ),
                            ],
                          );
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
