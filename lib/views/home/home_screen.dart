import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/providers/geolocation_provider.dart.dart';
import 'package:tabibu/views/clinics/clinic_details.dart';
import 'package:tabibu/views/home/components/home_list_view.dart';
import 'package:tabibu/widgets/app_drawer.dart';
import 'package:tabibu/widgets/spinner.dart';
import 'package:tabibu/widgets/suggested_clinic_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var locationService =
        Provider.of<GeolocationProvider>(context, listen: false);
    await locationService.getLocation();
    // locationService.getAddressFromLatLng(
    // locationService.latitude, locationService.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<GeolocationProvider>(
            builder: (context, value, child) {
              print(value.onGeolocationLoading);
              if (value.onGeolocationLoading == true) {
                return AppSpinner();
              } else if (value.onGeolocationLoading == false) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Consumer<GeolocationProvider>(
                    builder: (context, value, child) {
                      return Column(
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
                                    child: value.address != null
                                        ? Text(
                                            "${value.address}",
                                            style: Styles.heading2(context),
                                          )
                                        : const Text(""),
                                  ),
                                ),
                                Positioned(
                                  top: 65.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                              _scaffoldKey.currentState!
                                                  .openDrawer();
                                            },
                                          ),
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              showSearch(
                                                  context: context,
                                                  delegate: DataSearch());
                                            },
                                            child: TextField(
                                              autofocus: false,
                                              onTap: () {
                                                showSearch(
                                                    context: context,
                                                    delegate: DataSearch());
                                              },
                                              textInputAction:
                                                  TextInputAction.search,
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
                                                  context: context,
                                                  delegate: DataSearch());
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
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: Scrollable(
                                viewportBuilder: (context, position) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Align(
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
                                        const SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ClinicDetailsScreen(),
                                              ),
                                            );
                                          },
                                          child: const SuggestedClinic(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
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
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    RouteGenerator.clinicPage);
                                              },
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return HomePageListView();
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text("We can't reach your location"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
