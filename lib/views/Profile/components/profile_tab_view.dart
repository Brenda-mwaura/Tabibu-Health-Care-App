import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/providers/geolocation_provider.dart.dart';
import 'package:tabibu/widgets/inputs/image_picker_bottom_sheet.dart';
import 'package:tabibu/widgets/profile_display_text.dart';
import 'package:tabibu/widgets/spinner.dart';

class ProfileTabView extends StatefulWidget {
  ProfileTabView({Key? key}) : super(key: key);

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var locationService =
        Provider.of<GeolocationProvider>(context, listen: false);
    await locationService.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Scrollable(
        viewportBuilder: (context, position) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Stack(
                  children: [
                    //circle avatar
                    CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        child: const CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                AssetImage("assets/images/default.png"))
                        //  CircleAvatar(
                        //       radius: 65,
                        //       backgroundImage:
                        //     ),
                        ),
                    //camera icon
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Styles.primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return ImagePickerBottomSheet();
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const ProfileText(
                        icon: Icons.person,
                        displayTitle: "Name",
                        text: "John Doe",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ProfileText(
                        icon: Icons.info,
                        displayTitle: "About",
                        text:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ProfileText(
                        icon: Icons.email,
                        displayTitle: "Email",
                        text: "johndoe@gmail.com",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ProfileText(
                        icon: Icons.phone,
                        displayTitle: "Phone",
                        text: "+234 123 456 789",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ProfileText(
                        icon: Icons.calendar_month,
                        displayTitle: "DOB",
                        text: "01-01-2000",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<GeolocationProvider>(
                        builder: (context, locationService, child) {
                          return ProfileText(
                            icon: Icons.location_on,
                            displayTitle: "Location",
                            text: locationService.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
