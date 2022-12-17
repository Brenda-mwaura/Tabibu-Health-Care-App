import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tabibu/configs/styles.dart';
import 'package:tabibu/views/appointment/appointment_screen.dart';
import 'package:tabibu/views/Profile/profile_screen.dart';
import 'package:tabibu/views/clinics/clinics_screen.dart';
import 'package:tabibu/views/clinics/map_screen.dart';
import 'package:tabibu/views/home/home_screen.dart';

class HomeBaseScreen extends StatefulWidget {
  HomeBaseScreen({Key? key}) : super(key: key);

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    AppointmentScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: GNav(
            onTabChange: (index) {
              // print(index);
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            iconSize: 24,
            color: Colors.black87,
            activeColor: Styles.primaryColor,
            tabBackgroundColor: const Color.fromARGB(255, 244, 246, 250),
            padding: const EdgeInsets.all(16),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.map,
                text: 'Maps',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Schedule',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
