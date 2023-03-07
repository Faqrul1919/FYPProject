// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gmate/Gmate_page/home.dart';
import 'package:gmate/couns_page/c_home.dart';

import '../User_API/counselor_api_conn.dart';
import '../User_model/counselor_model.dart';
import '../sharedpreference/current_user.dart';

class CounsEditProfileState extends StatefulWidget {
  const CounsEditProfileState({Key? key}) : super(key: key);

  @override
  EditProfile createState() => EditProfile();
}

class EditProfile extends State<CounsEditProfileState> {
  final currentOnlineCounselor = Get.put(CurrentUser());

  final TextEditingController counselor_name = TextEditingController();
  final TextEditingController counselorID = TextEditingController();
  final TextEditingController counselor_room = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passwords = TextEditingController();

  updateCounselorRecord() async {
    User2 userModel = User2(
      currentOnlineCounselor.user2.counselor_id,
      counselor_name.text.trim().toString(),
      counselorID.text.trim().toString(),
      counselor_room.text.trim().toString(),
      email.text.trim().toString(),
      passwords.text.trim().toString(),
    );

    try {
      var res = await http.post(
        Uri.parse(Coun_API.updateCounProfile),
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

  bool showPassword = true;

  @override
  void initState() {
    super.initState();
    if (currentOnlineCounselor != null) {
      counselor_name.text = currentOnlineCounselor.user2.counselor_name;
      counselorID.text = currentOnlineCounselor.user2.counselorID;
      counselor_room.text = currentOnlineCounselor.user2.counselor_room;
      email.text = currentOnlineCounselor.user2.email;
      passwords.text = currentOnlineCounselor.user2.passwords;
    }
  }

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
            color: Colors.white,
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
            Column(
              children: [
                buildTextField("Full Name", counselor_name, false, true),
                buildTextField("Staff ID", counselorID, false, true),
                buildTextField("Couselling Room", counselor_room, false, false),
                buildTextField("E-mail", email, false, true),
                buildTextField("Password", passwords, true, false),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CounsHomeState()));
                  },
                  child: Text("CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                RaisedButton(
                  onPressed: () {
                    updateCounselorRecord();
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
                ),
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
      bool readOnlyText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: information,
        readOnly: readOnlyText,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
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
