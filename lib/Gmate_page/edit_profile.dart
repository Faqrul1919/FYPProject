// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gmate/Gmate_page/student_profile.dart';
import 'package:gmate/Gmate_page/home.dart';
import 'package:gmate/Gmate_page/studwntViewSubject.dart';
import 'package:gmate/User_model/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../User_API/student_api_conn.dart';
import '../sharedpreference/current_user.dart';

class EditProfileState extends StatefulWidget {
  const EditProfileState({Key? key}) : super(key: key);

  @override
  EditProfile createState() => EditProfile();
}

class EditProfile extends State<EditProfileState> {
  final currentOnlineUser = Get.put(CurrentUser());
  final TextEditingController student_name = TextEditingController();
  final TextEditingController stud_id = TextEditingController();
  final TextEditingController sem = TextEditingController();
  final TextEditingController phone_num = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController rating_code = TextEditingController();

  updateStudentRecord() async {
    User userModel = User(
      currentOnlineUser.user.acc_id,
      student_name.text.trim().toString(),
      stud_id.text.trim().toString(),
      sem.text.trim().toString(),
      phone_num.text.trim().toString(),
      email.text.trim().toString(),
      pass.text.trim().toString(),
      rating_code.text.trim().toString(),
    );

    try {
      var res = await http.post(
        Uri.parse(API.updateprofile),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfRegister = jsonDecode(res.body);
        if (resBodyOfRegister['success'] == true) {
          Fluttertoast.showToast(
              msg: "Successfully Update!", backgroundColor: Colors.green);
        } else {
          Fluttertoast.showToast(
              msg: "Failed to Update, Try again.", backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String? selectedSubject;

  List subList = [];

  Future getSubject() async {
    var url = "http://192.168.100.16/gmatedb/prof_sub.php";
    var response = await http.get(Uri.parse(url));
    var jsonbody = response.body;
    var jsonDatas = json.decode(jsonbody);
    setState(() {
      subList = jsonDatas;
    });

    print(jsonDatas);
    return "success";
  }

  String? selectedGroup;

  List gList = [];

  Future getGroup() async {
    var url = "http://192.168.100.16/gmatedb/prof_group.php";
    var response = await http.get(Uri.parse(url));
    var jsonbody = response.body;
    var jsonData = json.decode(jsonbody);
    setState(() {
      gList = jsonData;
    });

    print(jsonData);
    return "success";
  }

  String? selectedIntake;

  List iList = [];

  Future getIntake() async {
    var url = "http://192.168.100.16/gmatedb/prof_intake.php";
    var response = await http.get(Uri.parse(url));
    var jsonbody = response.body;
    var jsonData = json.decode(jsonbody);
    setState(() {
      iList = jsonData;
    });

    print(jsonData);
    return "success";
  }

  validateSubject() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateSubject),
        body: {
          "acc_id": currentOnlineUser.user.acc_id.toString(),
          "subject_id": selectedSubject.toString(),
          "group_id": selectedGroup.toString(),
          "intake_id": selectedIntake.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfValidateFavorite = jsonDecode(res.body);
        resBodyOfValidateFavorite['subjectFound'] == true;
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  addSubjectnGroupList() async {
    try {
      var res = await http.post(
        Uri.parse(API.addSubject),
        body: {
          "acc_id": currentOnlineUser.user.acc_id.toString(),
          "subject_id": selectedSubject.toString(),
          "group_id": selectedGroup.toString(),
          "intake_id": selectedIntake.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfAddFavorite = jsonDecode(res.body);
        if (resBodyOfAddFavorite['success'] == true) {
          Fluttertoast.showToast(
              msg: "Subject successfully added.",
              backgroundColor: Colors.green);

          validateSubject();
        } else {
          Fluttertoast.showToast(
              msg: "Subject has already registered.",
              backgroundColor: Colors.red);
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getSubject();
    getGroup();
    getIntake();
    if (currentOnlineUser != null) {
      student_name.text = currentOnlineUser.user.student_name;
      stud_id.text = currentOnlineUser.user.student_id;
      sem.text = currentOnlineUser.user.semester;
      phone_num.text = currentOnlineUser.user.phone_num;
      email.text = currentOnlineUser.user.email;
      pass.text = currentOnlineUser.user.passwords;
      rating_code.text = currentOnlineUser.user.rating_code;
    }
  }

  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEFF1),
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color(0xFF424242),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
              height: 35,
            ),
            buildTextField("Full Name", student_name, false, true, 50),
            buildTextField("Student ID", stud_id, false, true, 20),
            buildTextField("Semester", sem, false, false, 10),
            buildTextField("Phone Number", phone_num, false, false, 20),
            buildTextField("E-mail", email, false, true, 30),
            buildTextField("Password", pass, true, false, 20),
            buildTextField("Rating Code", rating_code, false, false, 5),
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton2(
                  hint: Center(
                    child: Text(
                      'Select Subject',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  value: selectedSubject,
                  items: subList.map((subject) {
                    return DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Center(
                                child: Visibility(
                              child: Text(
                                subject['subject_id'],
                              ),
                              visible: false,
                            )),
                            Center(child: Text(subject['title'])),
                          ],
                        ),
                        value: subject['subject_id']);
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSubject = value as String?;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 350,
                  itemHeight: 40,
                  isExpanded: true,
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 350,
                  dropdownPadding: null,
                ),
                SizedBox(
                  height: 35,
                ),
                DropdownButton2(
                  hint: Center(
                    child: Text(
                      'Select Group',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  value: selectedGroup,
                  items: gList.map((group) {
                    return DropdownMenuItem(
                      child: Center(
                          child: Row(
                        children: [
                          Visibility(
                            child: Text(group['group_id']),
                            visible: false,
                          ),
                          Text(
                            group['groups'],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                      value: group['group_id'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGroup = value as String?;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 150,
                  itemHeight: 40,
                  isExpanded: true,
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 150,
                  dropdownPadding: null,
                ),
                SizedBox(
                  height: 35,
                ),
                DropdownButton2(
                  hint: Center(
                    child: Text(
                      'Select Intake',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  value: selectedIntake,
                  items: iList.map((intake) {
                    return DropdownMenuItem(
                      child: Center(
                          child: Row(
                        children: [
                          Visibility(
                            child: Text(intake['intake_id']),
                            visible: false,
                          ),
                          Text(
                            intake['months'],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                      value: intake['intake_id'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedIntake = value as String?;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 250,
                  itemHeight: 40,
                  isExpanded: true,
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 250,
                  dropdownPadding: null,
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () {
                    addSubjectnGroupList();
                  },
                  color: Color.fromARGB(255, 0, 109, 33),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Get.to(StudentViewSubject());
                  },
                  color: Color.fromARGB(255, 179, 176, 16),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "VIEW SUBJECT",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Get.to(HomeState());
                  },
                  child: Text("CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                RaisedButton(
                  onPressed: () {
                    updateStudentRecord();
                  },
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, information, bool isPasswordTextField,
      bool readonlytext, int maxnum) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        maxLength: maxnum = 5,
        readOnly: readonlytext,
        controller: information,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            counterText: "",
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
