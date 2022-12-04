import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/widgets/clinics_widget/clinic_doctors_containers.dart';

class DoctorsTabView extends StatelessWidget {
  const DoctorsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Scrollable(
        viewportBuilder: (context, position) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Our Doctors",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return DoctorsContainer();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
