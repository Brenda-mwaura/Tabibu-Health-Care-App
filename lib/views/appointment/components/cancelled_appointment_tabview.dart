import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/providers/appointment_provider.dart';
import 'package:tabibu/widgets/clinics_widget/appoinment_container.dart';
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
    var clinicProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    await clinicProvider.fetchCancelledAppointment();
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
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.cancelledAppointments.length,
                        itemBuilder: (context, index) {
                          return AppointmentContainer(
                            status: "Cancelled",
                            statusColor: Colors.red,
                            appointment: value.cancelledAppointments[index],
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
