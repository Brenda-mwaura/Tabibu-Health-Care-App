import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/appointment_provider.dart';
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

  TextEditingController _appointmentFeeController = TextEditingController();
  TextEditingController _patientAppointmentDescriptionController =
      TextEditingController();
  TextEditingController _paymentPhoneNumberController = TextEditingController();
  TextEditingController _appointmentDateTextController =
      TextEditingController();
  TextEditingController _appointmentTimeTextController =
      TextEditingController();

  Future _selectAppointmentTime(BuildContext context) async {
    TimeOfDay initTime = TimeOfDay.now();

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
        print("Picked::: ${picked}");
        _appointmentTimeTextController.text = picked.format(context);
      });
    }
  }

  Future _selectAppointmentDate(BuildContext context) async {
    DateTime initDate = DateTime.now();

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(
        2015,
      ),
      lastDate: DateTime(2101),
    );
    if (selected != null) {
      _appointmentDateTextController.text =
          DateFormat('dd-MM-yyyy').format(selected);
      setState() {
        _appointmentDateTextController.text =
            DateFormat('dd-MM-yyyy').format(selected);
      }
    }
  }

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
    _appointmentFeeController.text = "0.00";
    _appointmentDateTextController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    _appointmentTimeTextController.text = TimeOfDay.now().format(context);
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
                          title: "Book Appointment",
                          formWidget: Consumer<ClinicProvider>(
                            builder: (context, clinicValue, child) {
                              return Form(
                                key: appointmentFormKey,
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Medical Service",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(
                                              255, 106, 106, 106),
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
                                                      BorderRadius.circular(
                                                          5.0))),
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
                                                  _appointmentFeeController
                                                          .text =
                                                      clinicValue
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
                                                  child: Text(value.serviceName
                                                      .toString()),
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
                                      controller: _appointmentFeeController,
                                      onChanged: (value) {},
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        fillColor: const Color.fromARGB(
                                            255, 245, 170, 51),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            // Color.fromARGB(255, 20, 106, 218),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Your message",
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
                                      autofocus: false,
                                      controller:
                                          _patientAppointmentDescriptionController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        fillColor: const Color.fromARGB(
                                            255, 245, 170, 51),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        hintText:
                                            "Describe how you are feeling",
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 106, 106, 106),
                                      ),
                                      maxLines: 5,
                                      minLines: 5,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
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
                                                    _appointmentDateTextController,
                                                autofocus: false,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  fillColor:
                                                      const Color.fromARGB(
                                                          255, 245, 170, 51),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    106,
                                                                    218),
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                  _selectAppointmentDate(
                                                      context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Column(
                                            children: [
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
                                                    _appointmentTimeTextController,
                                                autofocus: false,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  fillColor:
                                                      const Color.fromARGB(
                                                          255, 245, 170, 51),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    106,
                                                                    218),
                                                            width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  prefixIcon: const Icon(
                                                      Icons.access_time),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 106, 106, 106),
                                                ),
                                                readOnly: true,
                                                onTap: () async {
                                                  _selectAppointmentTime(
                                                      context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Phone 2547XXX",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 106, 106, 106),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 20,
                                            width: 100,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/tabibupay.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      controller: _paymentPhoneNumberController,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        hintText: "2547XXX",
                                        fillColor: const Color.fromARGB(
                                            255, 245, 170, 51),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            // Color.fromARGB(255, 20, 106, 218),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    AuthButton(
                                        onPressed: () {},
                                        child: Consumer<AppointmentProvider>(
                                          builder: (context, value, child) {
                                            return const Text(
                                              "Book Appointment",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                          },
                                        )),
                                    const SizedBox(height: 30),
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
