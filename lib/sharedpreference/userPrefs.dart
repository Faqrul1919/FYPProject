import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../User_model/counselor_model.dart';
import '../User_model/student_model.dart';

class RememberUserPrefs {
  static Future<void> saveUser(User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  static Future<User?> readUserInfo() async {
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");
    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}

class RememberCounselorPrefs {
  static Future<void> saveUser(User2 userInfo2) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo2.toJson());
    await preferences.setString("currentUser2", userJsonData);
  }

  static Future<User2?> readUserInfo2() async {
    User2? currentUserInfo2;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo2 = preferences.getString("currentUser2");
    if (userInfo2 != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo2);
      currentUserInfo2 = User2.fromJson(userDataMap);
    }
    return currentUserInfo2;
  }

  static Future<void> removeUserInfo2() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser2");
  }
}
