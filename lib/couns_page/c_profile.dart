import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gmate/Gmate_page/edit_profile.dart';
import 'package:gmate/couns_page/c_edit_profile.dart';
import 'package:gmate/started/get_started.dart';

import '../sharedpreference/current_user.dart';
import '../sharedpreference/userPrefs.dart';

class CounsProfileState extends StatefulWidget {
  const CounsProfileState({Key? key}) : super(key: key);

  @override
  CounsProfile createState() => CounsProfile();
}

class CounsProfile extends State<CounsProfileState> {
  final CurrentUser _currentCounselor = Get.put(CurrentUser());

  signout() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text("Comfirm Logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "No",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: "LoggedOut");
            },
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
    if (resultResponse == "LoggedOut") {
      RememberCounselorPrefs.removeUserInfo2().then((value) {
        Get.off(GetStartedState());
      });
    }
  }

  Widget userInfoProfile(IconData iconData, String counselorData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            counselorData,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEFF1),
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text(
          'HOME',
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              signout();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Your Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/unikl.png",
                            ))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
            ),
            userInfoProfile(
                Icons.person, _currentCounselor.user2.counselor_name),
            const SizedBox(
              height: 20,
            ),
            userInfoProfile(Icons.badge, _currentCounselor.user2.counselorID),
            const SizedBox(
              height: 20,
            ),
            userInfoProfile(Icons.room, _currentCounselor.user2.counselor_room),
            const SizedBox(
              height: 20,
            ),
            userInfoProfile(Icons.email_sharp, _currentCounselor.user2.email),
            SizedBox(
              height: 35,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    Get.to(CounsEditProfileState());
                  },
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
