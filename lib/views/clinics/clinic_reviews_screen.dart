import 'package:flutter/material.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/data/data_search.dart';
import 'package:tabibu/widgets/app_drawer.dart';
import 'package:tabibu/widgets/clinics_widget/reviews2_container.dart';
import 'package:tabibu/widgets/clinics_widget/reviews_container.dart';

class ClinicReviewsScreen extends StatefulWidget {
  ClinicReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ClinicReviewsScreen> createState() => _ClinicReviewsScreenState();
}

class _ClinicReviewsScreenState extends State<ClinicReviewsScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int index = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
        print(_tabController.index);
      });
    });
  }

  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
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
                            "Equity Afya Mombasa",
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
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
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
                                      textInputAction: TextInputAction.search,
                                      decoration: const InputDecoration(
                                        hintText: "Search review",
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
                                      Icons.filter_alt_off,
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
                        ),
                      )
                    ],
                  ),
                ),
                //
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Scrollable(viewportBuilder: (context, position) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Reviews2Container();
                              },
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
