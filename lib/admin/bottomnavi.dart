import 'package:flutter/material.dart';
import 'package:gmate/admin/groupList.dart';
import 'package:gmate/admin/adminStudentList.dart';
import 'package:gmate/admin/subjectList.dart';

class bottomNav extends StatefulWidget {
  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  int _currentIndex = 0;
  static List<Widget> pages = [SubjectList(), GroupList(), AStudentList()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.white.withOpacity(0.5),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.grey,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 55,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.chrome_reader_mode),
              icon: Icon(Icons.chrome_reader_mode_outlined),
              label: 'Subjects',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.class_),
              icon: Icon(Icons.class__outlined),
              label: 'Groups',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.badge),
              icon: Icon(Icons.badge_outlined),
              label: 'Students',
            ),
          ],
        ),
      ),
    );
  }
}
