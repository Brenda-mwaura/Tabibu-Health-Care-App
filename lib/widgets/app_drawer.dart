import 'package:flutter/material.dart';
import 'package:tabibu/configs/routes.dart';
import 'package:tabibu/configs/styles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Styles.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/images/afya.jpeg")
                      // NetworkImage(
                      //   profileService.profileDetails.profilePicture.toString(),
                      // ),
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "doe@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
                "Map",
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
                "Schedules",
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
                Navigator.of(context).pushNamed(RouteGenerator.loginPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
