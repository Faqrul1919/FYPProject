import 'dart:convert' show jsonDecode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmate/counselor/c_login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../User_API/counselor_api_conn.dart';
import '../User_model/counselor_model.dart';
import '../User_model/student_model.dart';

class CounselorRegisterState extends StatefulWidget {
  const CounselorRegisterState({Key? key}) : super(key: key);

  @override
  createState() => CounselorRegister();
}

class CounselorRegister extends State<CounselorRegisterState> {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();
  var counselorID = TextEditingController();
  var counselor_room = TextEditingController();
  var counselor_name = TextEditingController();

  validateEmail() async {
    try {
      var res = await http.post(Uri.parse(Coun_API.validateEmail), body: {
        'email': email.text.trim(),
      });
      if (res.statusCode == 200) //conn to api success
      {
        var resBodyValidateEmail = jsonDecode(res.body);

        if (resBodyValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(
              msg: "Email is already taken. Try another email",
              backgroundColor: Colors.red);
        } else {
          //reg and save to db
          registerCounselorRecord();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerCounselorRecord() async {
    User2 userModel = User2(
      1,
      counselor_name.text.trim(),
      counselorID.text.trim(),
      counselor_room.text.trim(),
      email.text.trim(),
      pass.text.trim(),
    );

    try {
      var res = await http.post(
        Uri.parse(Coun_API.register),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfRegister = jsonDecode(res.body);
        if (resBodyOfRegister['success'] == true) {
          Fluttertoast.showToast(
              msg: "Successfully Registered!", backgroundColor: Colors.green);

          setState(() {
            email.clear();
            pass.clear();
            counselorID.clear();
            counselor_room.clear();
            counselor_name.clear();
          });
        } else {
          Fluttertoast.showToast(
              msg: "Failed to register, Try again.",
              backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEFF1),
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text(
          'GMATE',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 80, right: 16),
        children: [
          Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'COUNSELOR',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: TextFormField(
                      controller: counselor_name,
                      validator: (val) =>
                          val == "" ? "Please enter your name" : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        fillColor: Color(0xFFB0BEC5),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: TextFormField(
                      controller: counselorID,
                      validator: (val) =>
                          val == "" ? "Please enter your Staff ID" : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Department',
                        fillColor: Color(0xFFB0BEC5),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: TextFormField(
                      controller: counselor_room,
                      validator: (val) =>
                          val == "" ? "Please enter your Office floor" : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Department',
                        fillColor: Color(0xFFB0BEC5),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: TextFormField(
                      controller: email,
                      validator: (val) =>
                          val == "" ? "Please enter your email" : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        fillColor: Color(0xFFB0BEC5),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: TextFormField(
                      obscureText: true,
                      controller: pass,
                      validator: (val) =>
                          val == "" ? "Please enter your password" : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        fillColor: Color(0xFFB0BEC5),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          validateEmail();
                        }
                      },
                      child: Text('REGISTER'),
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 17),
                          primary: Colors.grey,
                          fixedSize: const Size(180, 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)))),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account!"),
                      TextButton(
                        onPressed: () {
                          Get.to(CounselorLoginState());
                        },
                        child: const Text(
                          "Login Here",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
