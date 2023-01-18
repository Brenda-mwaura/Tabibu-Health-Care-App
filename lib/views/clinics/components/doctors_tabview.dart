import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/widgets/clinics_widget/clinic_doctors_containers.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/widgets/spinner.dart';

class DoctorsTabView extends StatefulWidget {
  final Clinic clinic;
  DoctorsTabView({Key? key, required this.clinic}) : super(key: key);

  @override
  State<DoctorsTabView> createState() => _DoctorsTabViewState();
}

class _DoctorsTabViewState extends State<DoctorsTabView> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    await clinicProvider.getClinicDoctors(widget.clinic.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RefreshIndicator(
        onRefresh: _refresh,
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
                  Consumer<ClinicProvider>(
                    builder: (context, value, child) {
                      if (value.clinicDoctorsLoading == true) {
                        return AppSpinner();
                      } else {
                        return value.clinicDoctors.isEmpty
                            ? Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 200,
                                child: SvgPicture.asset(
                                  "assets/images/signup.svg",
                                  fit: BoxFit.contain,
                                ),
                              )
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.clinicDoctors.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.85,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12,
                                ),
                                itemBuilder: (context, index) {
                                  return DoctorsContainer(
                                      doctor: value.clinicDoctors[index]);
                                },
                              );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
