import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/data/models/services.dart';
import 'package:tabibu/providers/appointment_provider.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/widgets/clinics_widget/appoinment_container.dart';
import 'package:tabibu/widgets/clinics_widget/cancelled_appointment_container.dart';
import 'package:tabibu/widgets/spinner.dart';

class CancelledAppointmentTabView extends StatefulWidget {
  CancelledAppointmentTabView({Key? key}) : super(key: key);

  @override
  State<CancelledAppointmentTabView> createState() =>
      _CancelledAppointmentTabViewState();
}

class _CancelledAppointmentTabViewState
    extends State<CancelledAppointmentTabView> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    await appointmentProvider.fetchCancelledAppointment();

    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    await clinicProvider.fetchClinics();

    await clinicProvider.getClinicServices();
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
                if (value.cancelledAppointmentLoading == true) {
                  return AppSpinner();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      value.cancelledAppointments.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 200,
                              child: SvgPicture.asset(
                                "assets/images/cancelled.svg",
                                fit: BoxFit.contain,
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.cancelledAppointments.length,
                              itemBuilder: (context, index) {
                                return Consumer<ClinicProvider>(
                                  builder: (context, clinicValue, child) {
                                    if (clinicValue.clinicsLoading == true ||
                                        clinicValue.servicesLoading == true) {
                                      return AppSpinner();
                                    } else {
                                      List<Clinic> clinics =
                                          clinicValue.clinics;

                                      int clinicId = int.parse(value
                                          .cancelledAppointments[index].clinic
                                          .toString());
                                      Clinic clinic = clinics.firstWhere(
                                          (clinic) => clinic.id == clinicId);

                                      // clinic service
                                      List<ClinicServices> services =
                                          clinicValue.clinicServices;
                                      int serviceId = int.parse(value
                                          .cancelledAppointments[index].service
                                          .toString());
                                      ClinicServices service =
                                          services.firstWhere((service) =>
                                              service.id == serviceId);

                                      return AppointmentContainer(
                                        service: service,
                                        clinic: clinic,
                                        status: "Cancelled",
                                        statusColor: Colors.red,
                                        appointment:
                                            value.cancelledAppointments[index],
                                      );
                                    }
                                  },
                                );
                              },
                            )
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
