import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/providers/geolocation_provider.dart.dart';
import 'package:tabibu/providers/profile_provider.dart';
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

    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider.fetchProfile();
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
            child: Consumer<ProfileProvider>(
              builder: (context, value, child) {
                if (value.profileLoading == true) {
                  return AppSpinner();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey,
                            child: value.profileDetails.profilePicture == null
                                ? const CircleAvatar(
                                    radius: 65,
                                    backgroundImage:
                                        AssetImage("assets/images/default.png"),
                                  )
                                : CircleAvatar(
                                    radius: 65,
                                    backgroundImage: NetworkImage(
                                      value.profileDetails.profilePicture
                                          .toString(),
                                    ),
                                  ),
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
                            ProfileText(
                              icon: Icons.person,
                              displayTitle: "Name",
                              text: value.profileDetails.user!.fullName
                                  .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ProfileText(
                              icon: Icons.info,
                              displayTitle: "About",
                              text: value.profileDetails.bio.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ProfileText(
                              icon: Icons.email,
                              displayTitle: "Email",
                              text: value.profileDetails.user!.email.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ProfileText(
                              icon: Icons.phone,
                              displayTitle: "Phone",
                              text: value.profileDetails.user!.phone.toString(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ProfileText(
                              icon: Icons.calendar_month,
                              displayTitle: "DOB",
                              text:
                                  // value.profileDetails.dateOfBirth == null
                                  //     ? ""
                                  //     :
                                  value.profileDetails.dateOfBirth.toString(),
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
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
