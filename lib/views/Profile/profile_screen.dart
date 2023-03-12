import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/views/Profile/components/notifications_tab_view.dart';
import 'package:tabibu/views/Profile/components/profile_edit_tabview.dart';
import 'package:tabibu/views/Profile/components/profile_tab_view.dart';
import 'package:tabibu/widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  final int initialPageIndex;
  ProfileScreen({Key? key, this.initialPageIndex = 0}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int index = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialPageIndex,
    );
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
          child: Column(
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
                          'Profile',
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                  text: "Profile",
                                ),
                                Tab(
                                  text: "Edit",
                                ),
                                Tab(
                                  text: "Notifications",
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ProfileTabView(),
                      ProfileEditTabView(),
                      NotificationTabView(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
