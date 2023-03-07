import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmate/Gmate_page/search.dart';
import 'package:gmate/Gmate_page/student_list.dart';
import 'package:gmate/Gmate_page/student_profile.dart';

import '../sharedpreference/current_user.dart';
import 'chat.dart';

class HomeState extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _fragmentScreens = [
    StudentProfileState(),
    SearchState(),
    StudentChatState(),
  ];

  List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.search,
      "non_active_icon": Icons.search_outlined,
      "label": "Search",
    },
    {
      "active_icon": Icons.chat,
      "non_active_icon": Icons.chat_outlined,
      "label": "Chat",
    },
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Obx(() => _fragmentScreens[_indexNumber.value]),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              backgroundColor: Color.fromARGB(255, 194, 193, 193),
              currentIndex: _indexNumber.value,
              onTap: (value) {
                _indexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.black,
              unselectedItemColor: Color.fromARGB(255, 43, 43, 43),
              items: List.generate(3, (index) {
                var navBtnProperty = _navigationButtonsProperties[index];
                return BottomNavigationBarItem(
                  backgroundColor: Colors.black,
                  icon: Icon(navBtnProperty["non_active_icon"]),
                  activeIcon: Icon(navBtnProperty["active_icon"]),
                  label: navBtnProperty["label"],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
