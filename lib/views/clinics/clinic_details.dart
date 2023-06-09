import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/appointment_provider.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/providers/profile_provider.dart';
import 'package:tabibu/services/validators.dart';
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

  Future _appointmentBookingFnc(String? currentSelectedValue) async {
    if (appointmentFormKey.currentState!.validate()) {
      if (currentSelectedValue != null) {
        String formattedAppointmentDate = DateFormat('yyyy-MM-dd').format(
            DateFormat("dd-MM-yyyy")
                .parse(_appointmentDateTextController.text));

        final format = DateFormat.jm();
        TimeOfDay formttedAppointmentTime = TimeOfDay.fromDateTime(
            format.parse(_appointmentTimeTextController.text));

        String appointmentTime =
            "${formttedAppointmentTime.hour}:${formttedAppointmentTime.minute}:00";

        await appointmentProvider
            .appointmentBooking(
                widget.clinic.id,
                formattedAppointmentDate,
                appointmentTime,
                int.parse(currentSelectedValue.toString()),
                _paymentPhoneNumberController.text,
                _patientAppointmentDescriptionController.text)
            .then((value) async {
          if (value != null) {
            await appointmentProvider.lipaAppointmentNaMpesaOnline(
              _paymentPhoneNumberController.text,
              int.parse(currentSelectedValue.toString()),
              widget.clinic.id,
            );
            Navigator.of(context).pushNamed(RouteGenerator.appointmentPage);
            currentSelectedValue = "";
            _appointmentFeeController.clear();
            _patientAppointmentDescriptionController.clear();
            _appointmentDateTextController.text =
                DateFormat('dd-MM-yyyy').format(DateTime.now());
            _appointmentTimeTextController.text =
                DateFormat('jm').format(DateTime.now());
          }
        });
      } else {
        Fluttertoast.showToast(
          msg: "Please select a medical service",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Styles.primaryColor,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }
    }
  }

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
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider.fetchProfile();
    _paymentPhoneNumberController.text =
        profileProvider.profileDetails.user!.phone.toString();

    clinicProvider
        .getClinicMedicalServices(int.parse(widget.clinic.id.toString()));
    // clinicProvider.getMedService();
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
                              style: Styles.heading1(context,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 22,
                          left: 5,
                          child: Material(
                            color: Styles.primaryColor,
                            child: InkWell(
                              splashColor: Styles.primaryColor,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
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
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TabBar(
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Styles.primaryColor,
                                  ),
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: Styles.custom18(context,
                                      fontWeight: FontWeight.w700),
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
                        DirectionsTabView(clinic: widget.clinic),
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
                          initialHeight: 0.87,
                          title: "Book Appointment",
                          formWidget: Consumer<ClinicProvider>(
                            builder: (context, clinicValue, child) {
                              return Form(
                                key: appointmentFormKey,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Medical Service",
                                        style: Styles.normal(context,
                                            fontColor: const Color.fromARGB(
                                                255, 106, 106, 106),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                              labelStyle: Styles.custom18(
                                                  context,
                                                  fontColor: Colors.black),
                                              errorStyle: Styles.custom18(
                                                  context,
                                                  fontColor: Colors.redAccent),
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
                                              //validate to ensure that user selects service

                                              onChanged: (value) async {
                                                var clinicProvider =
                                                    Provider.of<ClinicProvider>(
                                                        context,
                                                        listen: false);
                                                await clinicProvider
                                                    .getMedicalServiceDetails(
                                                        int.parse(
                                                            value.toString()));
                                                setState(() {
                                                  _appointmentFeeController
                                                          .text =
                                                      clinicValue
                                                          .clinicMedicalServiceDetails
                                                          .price
                                                          .toString();
                                                  _currentSelectedValue =
                                                      value.toString();
                                                  state.didChange(value);
                                                });
                                              },
                                              items: clinicValue
                                                  .clinicMedServiceDetailed
                                                  .map((value) {
                                                final service = clinicValue
                                                    .clinicServices
                                                    .where((service) =>
                                                        service.id == value.id)
                                                    .first;

                                                // var serviceName=clinicValue.clinicServices.where((service)=>service.id==value.id).toList();
                                                return DropdownMenuItem<String>(
                                                  value: value.id.toString(),
                                                  child: Text(service
                                                      .serviceName
                                                      .toString()),
                                                  // Text(value.service
                                                  //     .toString()),
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
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Consultation fee",
                                          style: Styles.normal(context,
                                              fontColor: const Color.fromARGB(
                                                  255, 106, 106, 106),
                                              fontWeight: FontWeight.w500)),
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
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Your message",
                                          style: Styles.normal(context,
                                              fontColor: const Color.fromARGB(
                                                  255, 106, 106, 106),
                                              fontWeight: FontWeight.w500)),
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
                                      style: Styles.custom18(context,
                                          fontColor: const Color.fromARGB(
                                              255, 106, 106, 106)),
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
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Date",
                                                    style: Styles.normal(
                                                        context,
                                                        fontColor: const Color
                                                                .fromARGB(
                                                            255, 106, 106, 106),
                                                        fontWeight:
                                                            FontWeight.w500)),
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
                                                style: Styles.custom18(context,
                                                    fontColor:
                                                        const Color.fromARGB(
                                                            255,
                                                            106,
                                                            106,
                                                            106)),
                                                readOnly: true,
                                                onTap: () async {
                                                  _selectAppointmentDate(
                                                      context);
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please select date";
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Time",
                                                    style: Styles.normal(
                                                        context,
                                                        fontColor: const Color
                                                                .fromARGB(
                                                            255, 106, 106, 106),
                                                        fontWeight:
                                                            FontWeight.w500)),
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
                                                style: Styles.custom18(context,
                                                    fontColor:
                                                        const Color.fromARGB(
                                                            255,
                                                            106,
                                                            106,
                                                            106)),
                                                readOnly: true,
                                                onTap: () async {
                                                  _selectAppointmentTime(
                                                      context);
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please select time";
                                                  }
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
                                          Expanded(
                                            child: Text("Phone 2547XXX",
                                                style: Styles.normal(context,
                                                    fontColor:
                                                        const Color.fromARGB(
                                                            255, 106, 106, 106),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 20,
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                                right: 10),
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
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter phone number";
                                        }
                                        if (!RegExp(r"^[+0-9]*$")
                                            .hasMatch(value)) {
                                          return "Please enter valid phone number";
                                        }
                                      },
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
                                    AuthButton(onPressed: () {
                                      _appointmentBookingFnc(
                                          _currentSelectedValue);
                                    }, child: Consumer<AppointmentProvider>(
                                      builder: (context, value, child) {
                                        return Text("Book Appointment",
                                            style: Styles.custom20(context,
                                                fontColor: Colors.white,
                                                fontWeight: FontWeight.w500));
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
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
      ),
    );
  }
}
