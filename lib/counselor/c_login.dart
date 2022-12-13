import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmate/counselor/c_register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

import '../User_API/counselor_api_conn.dart';
import '../User_model/counselor_model.dart';
import '../User_model/student_model.dart';
import '../couns_page/c_home.dart';
import '../sharedpreference/userPrefs.dart';

class CounselorLoginState extends StatefulWidget {
  const CounselorLoginState({Key? key}) : super(key: key);

  @override
  createState() => CounselorLogin();
}

class CounselorLogin extends State<CounselorLoginState> {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();

  Future login() async {
    try {
      var res = await http.post(
        Uri.parse(Coun_API.login),
        body: {
          "email": email.text.trim(),
          "passwords": pass.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(
              msg: "Successfully Login!", backgroundColor: Colors.green);

          User2 userInfo2 = User2.fromJson(resBodyOfLogin["userData"]);

          await RememberCounselorPrefs.saveUser(userInfo2);
          Future.delayed(Duration(milliseconds: 2000), () {
            Get.to(CounsHomeState());
          });
        } else {
          Fluttertoast.showToast(
              msg: "Incorrect Email or Password. \nTry again!",
              backgroundColor: Colors.red);
        }
      }
    } catch (errorMessage) {
      print("Error ::" + errorMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEFF1),
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text('GMATE'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 150, right: 16),
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
                    child: TextFormField(
                      controller: email,
                      validator: (val) =>
                          val == "" ? "Please enter your email" : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
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
                    child: TextFormField(
                      controller: pass,
                      validator: (val) =>
                          val == "" ? "Please enter your password" : null,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key_sharp,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        fillColor: Color(0xFFB0BEC5),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: Text('LOGIN'),
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 17),
                          primary: Colors.grey,
                          fixedSize: const Size(210, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)))),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => CounselorRegisterState()));
                      },
                      child: Text('SIGN UP'),
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 17),
                          primary: Colors.grey,
                          fixedSize: const Size(210, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)))),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(CounsHomeState());
                      },
                      child: Text('try&error'),
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 17),
                          primary: Colors.grey,
                          fixedSize: const Size(210, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
