import 'dart:convert' show jsonDecode;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmate/bse_student/login.dart';
import 'package:gmate/bse_student/login.dart';
import 'package:gmate/User_API/student_api_conn.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../User_model/student_model.dart';
import 'login.dart';

class StudentRegisterState extends StatefulWidget {
  const StudentRegisterState({Key? key}) : super(key: key);

  @override
  createState() => StudentRegister();
}

class StudentRegister extends State<StudentRegisterState> {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();
  var sem = TextEditingController();
  var stud_id = TextEditingController();
  var stud_name = TextEditingController();
  var phone_num = TextEditingController();
  var rating_code = TextEditingController();

  validateEmail() async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail), body: {
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
          registerStudentRecord();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerStudentRecord() async {
    User userModel = User(
      0,
      stud_name.text.trim(),
      stud_id.text.trim(),
      sem.text.trim(),
      phone_num.text.trim(),
      email.text.trim(),
      pass.text.trim(),
      rating_code.text.trim(),
    );

    try {
      var res = await http.post(
        Uri.parse(API.register),
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
            sem.clear();
            phone_num.clear();
            stud_id.clear();
            stud_name.clear();
            rating_code.clear();
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
      body: GestureDetector(
        child: ListView(
          padding: EdgeInsets.only(left: 16, top: 80, right: 16),
          children: [
            Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BSE STUDENT',
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
                      height: 70,
                      child: TextFormField(
                        controller: stud_name,
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
                      height: 70,
                      child: TextFormField(
                        controller: stud_id,
                        validator: (val) =>
                            val == "" ? "Please enter your student ID" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Student ID',
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
                      height: 70,
                      child: TextFormField(
                        controller: sem,
                        validator: (val) =>
                            val == "" ? "Please enter your semester" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Semester',
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
                      height: 70,
                      child: TextFormField(
                        controller: phone_num,
                        validator: (val) =>
                            val == "" ? "Please enter your phone number" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
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
                      height: 70,
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
                      height: 70,
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
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      height: 70,
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        controller: rating_code,
                        validator: (val) =>
                            val == "" ? "Please enter your rating_code" : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Rating Code',
                          fillColor: Color(0xFFB0BEC5),
                          filled: true,
                        ),
                      ),
                    ),
                    Text(
                      "Hint: Only required 5 digit number",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
                            Get.to(StudentLoginState());
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
