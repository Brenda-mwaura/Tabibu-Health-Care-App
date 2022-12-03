import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/views/appointment/components/cancelled_appointment_tabview.dart';
import 'package:tabibu/views/appointment/components/completed_appointment_tabview.dart';
import 'package:tabibu/views/appointment/components/upcoming_appointment_tabview.dart';
import 'package:tabibu/widgets/app_drawer.dart';
import 'package:tabibu/widgets/buttons/auth_button.dart';

class ClinicDetailsScreen extends StatefulWidget {
  ClinicDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ClinicDetailsScreen> createState() => _ClinicDetailsScreenState();
}

class _ClinicDetailsScreenState extends State<ClinicDetailsScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int index = 0;
  late TabController _tabController;

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
                  // button at the bottom of the screen
                  // Expanded(
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  //     child:
                  //         TabBarView(controller: _tabController, children: []),
                  //   ),
                  // )
                  //button at the bottom of the screen
                ],
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: AuthButton(
                    onPressed: () {},
                    child: const Text(
                      "Book Appointment",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
