import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      body: SizedBox(
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
                        "Clinics",
                        style: Styles.heading2(context),
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
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Styles.primaryColor,
                              ),
                              onPressed: () {
                                print("your menu action here");
                                _scaffoldKey.currentState!.openDrawer();
                              },
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                showSearch(
                                    context: context, delegate: DataSearch());
                              },
                              child: TextField(
                                autofocus: false,
                                onTap: () {
                                  showSearch(
                                      context: context, delegate: DataSearch());
                                },
                                textInputAction: TextInputAction.search,
                                decoration: const InputDecoration(
                                  hintText: "Search Clinic",
                                  focusColor: Colors.white,
                                  fillColor: Colors.white,
                                ),
                              ),
                            )),
                            IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Styles.primaryColor,
                              ),
                              onPressed: () {
                                showSearch(
                                    context: context, delegate: DataSearch());
                                print("your menu action here");
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications,
                                color: Styles.primaryColor,
                              ),
                              onPressed: () {
                                print("your menu action here");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
