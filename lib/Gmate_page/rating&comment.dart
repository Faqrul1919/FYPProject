// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gmate/Gmate_page/studentinformation.dart';
import 'package:http/http.dart' as http;
import '../User_API/student_api_conn.dart';
import '../User_model/student_model.dart';

class StudentRatingInformationScreen extends StatefulWidget {
  final Student_Favourite? ratestud;

  StudentRatingInformationScreen({
    this.ratestud,
  });

  @override
  State<StudentRatingInformationScreen> createState() => _StudentRatingReview();
}

class _StudentRatingReview extends State<StudentRatingInformationScreen> {
  final TextEditingController rating = TextEditingController();
  final TextEditingController comments = TextEditingController();

  rateStudentFavorite() async {
    try {
      var res = await http.post(
        Uri.parse(API.addRatingReview),
        body: {
          "acc_id": widget.ratestud!.acc_id.toString(),
          "rating": rating.text.toString(),
          "comments": comments.text.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfRegister = jsonDecode(res.body);
        if (resBodyOfRegister['success'] == true) {
          Fluttertoast.showToast(
              msg: "Successfully Submit!", backgroundColor: Colors.green);
          setState(() {
            rating.clear();
            comments.clear();
          });
        } else {
          Fluttertoast.showToast(
              msg: "Failed to Submit, Try again.", backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Image(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            image: AssetImage(
              "assets/images/unikl2.png",
            ),
          ),
          //item information
          Align(
            alignment: Alignment.bottomCenter,
            child: studentRatingWidget(),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 2,
            right: 15,
            child: Row(
              children: [
                //back
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  studentRatingWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 199, 198, 198),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Color.fromARGB(255, 49, 48, 49),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),

            //name
            Center(
              child: Text(
                "Rate & Comment",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Divider(
              height: 1,
              thickness: 2,
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "Give Rate and Comment to :",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                widget.ratestud!.studentname!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Rate:",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Center(
              child: SizedBox(
                width: 100,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: rating,
                  maxLength: 1,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[1-5]'),
                    ),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "?/5",
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 10,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Center(
              child: Text(
                "Hint: Number of rate given should be less than 5",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                "eg: 1.8, 2.5, 3.7, 4.4",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Comment:",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Center(
              child: SizedBox(
                width: 400,
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLength: 255,
                  controller: comments,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: null,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 10,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: RaisedButton(
                onPressed: () {
                  rateStudentFavorite();
                },
                color: Color.fromARGB(255, 0, 109, 33),
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
