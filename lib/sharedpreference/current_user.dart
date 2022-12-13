import 'package:get/get.dart';
import 'package:gmate/sharedpreference/userPrefs.dart';
import 'package:gmate/User_model/student_model.dart';

import '../User_model/counselor_model.dart';

class CurrentUser extends GetxController {
  Rx<User> _currentUser = User(0, '', '', '', '', '', '', '').obs;
  Rx<User2> _currentCounselor = User2(0, '', '', '', '', '').obs;

  User get user => _currentUser.value;
  User2 get user2 => _currentCounselor.value;

  getUserInfo() async {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }

  getCounselorInfo() async {
    User2? getUserInfoFromLocalStorage =
        await RememberCounselorPrefs.readUserInfo2();
    _currentCounselor.value = getUserInfoFromLocalStorage!;
  }
}
