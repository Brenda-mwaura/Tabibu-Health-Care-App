import 'package:flutter/material.dart';
import 'package:tabibu/widgets/clinics_widget/appoinment_container.dart';

class CancelledAppointmentTabView extends StatelessWidget {
  const CancelledAppointmentTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (context, position) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  // return const AppointmentContainer(
                  //   status: "Cancelled",
                  //   statusColor: Colors.red,
                  // );
                  return Text("Cancelled...");
                },
              )
            ],
          ),
        );
      },
    );
  }
}
