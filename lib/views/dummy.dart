Column(
          children: [
            SizedBox(
              height: 138,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100.0,
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
                    top: 80.0,
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
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search Clinic",
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Styles.primaryColor,
                              ),
                              onPressed: () {
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
            //nearby clinic text
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
            // Container with the most nearby clinic
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: SuggestedClinic(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Container(
            //   margin: const EdgeInsets.only(
            //     left: 15.0,
            //     right: 18.0,
            //   ),
            //   child: Row(
            //     children: [
            //       const Text(
            //         "Other Nearby facilities",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 20.0,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       const Spacer(),
            //       InkWell(
            //         onTap: () {},
            //         child: const Text(
            //           "See all",
            //           style: TextStyle(
            //             color: Styles.primaryColor,
            //             fontSize: 18.0,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 1,
            //     itemBuilder: (context, index) {
            //       return Container();
            //     },
            //   ),
            // ),
          ],
        ),