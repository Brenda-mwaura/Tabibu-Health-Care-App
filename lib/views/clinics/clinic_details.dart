import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/views/appointment/components/cancelled_appointment_tabview.dart';
import 'package:tabibu/views/appointment/components/completed_appointment_tabview.dart';
import 'package:tabibu/views/appointment/components/upcoming_appointment_tabview.dart';
import 'package:tabibu/views/clinics/components/about_tabview.dart';
import 'package:tabibu/views/clinics/components/directions_tabview.dart';
import 'package:tabibu/views/clinics/components/doctors_tabview.dart';
import 'package:tabibu/widgets/app_drawer.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';
import 'package:tabibu/widgets/clinics_widget/schedule_bottom_sheet.dart';

class ClinicDetailsScreen extends StatefulWidget {
  final Clinic clinic;
  ClinicDetailsScreen({Key? key, required this.clinic}) : super(key: key);

  @override
  State<ClinicDetailsScreen> createState() => _ClinicDetailsScreenState();
}

class _ClinicDetailsScreenState extends State<ClinicDetailsScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int index = 0;
  late TabController _tabController;
  var _currentSelectedValue;

  GlobalKey<FormState> appointmentFormKey = GlobalKey<FormState>();

  TextEditingController _appointmentFee = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
        print(_tabController.index);
      });
    });
    _refresh();
  }

  Future<void> _refresh() async {
    var clinicProvider = Provider.of<ClinicProvider>(context, listen: false);
    await clinicProvider.getClinicServices();
    _appointmentFee.text = "0.00";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 125,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 85.0,
                          decoration: const BoxDecoration(
                            color: Styles.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Clinic Details",
                              style: Styles.heading2(context),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 65.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.0),
                                  color: Colors.white),
                              //implement tab bar
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TabBar(
                                  controller: _tabController,
                                  // indicatorColor: Styles.primaryColor,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Styles.primaryColor,
                                  ),
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  tabs: const [
                                    Tab(
                                      text: "About",
                                    ),
                                    Tab(
                                      text: "Directions",
                                    ),
                                    Tab(
                                      text: "Doctors",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        AboutClinicTabView(
                          clinic: widget.clinic,
                        ),
                        DirectionsTabView(),
                        DoctorsTabView(
                          clinic: widget.clinic,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: RawMaterialButton(
              onPressed: () async {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return ScheduleBottomSheet(
                          formWidget: Consumer<ClinicProvider>(
                        builder: (context, clinicValue, child) {
                          return Form(
                            key: appointmentFormKey,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onHorizontalDragDown: (details) {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 0, bottom: 5),
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Styles.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    "Book Appointment",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Medical Service",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.0),
                                          errorStyle: const TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 16.0),
                                          hintText: 'Please select service',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                      isEmpty: _currentSelectedValue == "",
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _currentSelectedValue,
                                          isDense: true,
                                          onChanged: (value) async {
                                            var clinicProvider =
                                                Provider.of<ClinicProvider>(
                                                    context,
                                                    listen: false);
                                            await clinicProvider
                                                .getClinicServiceDetails(
                                                    int.parse(
                                                        value.toString()));
                                            setState(() {
                                              _appointmentFee.text = clinicValue
                                                  .serviceDetails.price
                                                  .toString();
                                              _currentSelectedValue =
                                                  value.toString();
                                              state.didChange(value);
                                            });
                                          },
                                          items: clinicValue.clinicServices
                                              .map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value.id.toString(),
                                              child: Text(
                                                  value.serviceName.toString()),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Consultation fee",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 106, 106, 106),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: _appointmentFee,
                                  onChanged: (value) {},
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    fillColor:
                                        const Color.fromARGB(255, 245, 170, 51),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        // Color.fromARGB(255, 20, 106, 218),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ));
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
                "Book Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
      ),
    );
  }
}
