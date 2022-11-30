import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/views/home/components/home_list_view.dart';
import 'package:tabibu/widgets/suggested_clinic_widget.dart';
// import 'package:tabibu/widgets/appbar_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              height: 125,
              child: Stack(
                children: <Widget>[
                  Container(
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
                        "Dashboard",
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
            ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nearby Clinic",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  child: SuggestedClinic(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15.0,
                    right: 18.0,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Other Nearby facilities",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "See all",
                          style: TextStyle(
                            color: Styles.primaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                  ),
                  child: HomePageListView(),
                )
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   iconSize: 20,
      //   selectedFontSize: 20,
      //   selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
      //   selectedItemColor: Colors.amberAccent,
      //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      //   unselectedIconTheme: IconThemeData(
      //     color: Colors.deepOrangeAccent,
      //   ),
      //   unselectedItemColor: Colors.deepOrangeAccent,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.call),
      //       label: 'Calls',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera),
      //       label: 'Camera',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat),
      //       label: 'Chats',
      //     ),
      //   ],
      // ),
    );
  }
}
