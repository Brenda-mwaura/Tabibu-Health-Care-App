import 'package:flutter/material.dart';
import 'package:tabibu/widgets/clinics_widget/clinic_list_widget.dart';

class HomePageListView extends StatelessWidget {
  const HomePageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: const ClinicWidget(),
        );
      },
    );
  }
}
