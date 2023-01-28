import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/providers/auth_provider.dart';
import 'package:tabibu/providers/profile_provider.dart';
import 'package:tabibu/services/navigation_service.dart';
import 'package:tabibu/views/Profile/profile_screen.dart';
import 'package:tabibu/widgets/spinner.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future _logout() async {
      await authProvider.logout();
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteGenerator.loginPage, (Route<dynamic> route) => false);
    }

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Styles.primaryColor,
              child: Consumer<ProfileProvider>(
                builder: (context, value, child) {
                  if (value.profileLoading == true) {
                    return const Center(
                      child: AppSpinner(),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        value.profileDetails.profilePicture == null
                            ? const CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    AssetImage("assets/images/default.png"),
                              )
                            : CircleAvatar(
                                radius: 55,
                                backgroundImage: NetworkImage(
                                  value.profileDetails.profilePicture
                                      .toString(),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          value.profileDetails.user!.email == null
                              ? ""
                              : value.profileDetails.user!.email.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          value.profileDetails.user!.fullName == null
                              ? ""
                              : value.profileDetails.user!.fullName.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.homeBasePage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.healing,
                color: Colors.black,
              ),
              title: const Text(
                "Clinics",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.clinicPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.map,
                color: Colors.black,
              ),
              title: const Text(
                "Maps",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.mapPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: const Text("Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.profilePage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
              title: const Text(
                "Schedule",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.appointmentPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: const Text(
                "Help",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                _logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
