import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gmate/bse_student/login.dart';
import 'package:gmate/sharedpreference/userPrefs.dart';
import 'package:gmate/started/get_started.dart';

import 'Gmate_page/home.dart';
import 'couns_page/c_home.dart';

// void main() async {
//   runApp(const MaterialApp(home: GetStartedState()));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return studentUserPreferenceWidget();
  }
}

studentUserPreferenceWidget() {
  return GetMaterialApp(
    home: FutureBuilder(
      future: RememberUserPrefs.readUserInfo(),
      builder: (context, dataSnapShot) {
        if (dataSnapShot.data == null) {
          return GetStartedState();
        } else {
          return HomeState();
        }
      },
    ),
  );
}

counselorUserPreferenceWidget() {
  return GetMaterialApp(
    home: FutureBuilder(
      future: RememberCounselorPrefs.readUserInfo2(),
      builder: (context, dataSnapShot) {
        if (dataSnapShot.data == null) {
          return GetStartedState();
        } else {
          return CounsHomeState();
        }
      },
    ),
  );
}
