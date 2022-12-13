import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gmate/User_API/student_api_conn.dart';

import 'package:http/http.dart' as http;

import '../User_model/student_model.dart';
import '../sharedpreference/current_user.dart';

class StudentViewSubject extends StatefulWidget {
  @override
  State<StudentViewSubject> createState() => _StudentViewSubject();
}

class _StudentViewSubject extends State<StudentViewSubject> {
  final currentOnlineUser = Get.put(CurrentUser());

  Future<List<RegisteredSubject>> getSubjectList() async {
    List<RegisteredSubject> subjectList = [];

    try {
      var res = await http.post(Uri.parse(API.readSubject), body: {
        "acc_id": currentOnlineUser.user.acc_id.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyOfCurrentUsersUBJECTListItems = jsonDecode(res.body);

        if (responseBodyOfCurrentUsersUBJECTListItems['success'] == true) {
          (responseBodyOfCurrentUsersUBJECTListItems['studentSubjectData']
                  as List)
              .forEach((eachCurrentUserSubjectItemData) {
            subjectList.add(
                RegisteredSubject.fromJson(eachCurrentUserSubjectItemData));
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error:: " + errorMsg.toString());
    }

    return subjectList;
  }

  deletesubjectList(int subjID) async {
    try {
      var res = await http.post(Uri.parse(API.deleteSubject), body: {
        "stud_reg": subjID.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyFromDeleteCart = jsonDecode(res.body);

        if (responseBodyFromDeleteCart["success"] == true) {
          Fluttertoast.showToast(
              msg: "Successfully delete!", backgroundColor: Colors.red);
          getSubjectList();
        }
      } else {
        Fluttertoast.showToast(msg: "Error, Status Code is not 200");
      }
    } catch (errorMessage) {
      print("Error: " + errorMessage.toString());

      Fluttertoast.showToast(msg: "Error: " + errorMessage.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getSubjectList();
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
            child: studentReviewWidget(),
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

  studentReviewWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.62,
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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 18,
            ),
            //name
            Center(
              child: Text(
                'Subject',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            Divider(
              height: 1,
              thickness: 2,
            ),

            Align(child: subjectListWidget(context)),
          ],
        ),
      ),
    );
  }

  subjectListWidget(context) {
    return FutureBuilder(
        future: getSubjectList(),
        builder:
            (context, AsyncSnapshot<List<RegisteredSubject>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return const Center(
              child: Text(
                "No Subject",
              ),
            );
          }
          if (dataSnapShot.data!.length > 0) {
            return ListView.builder(
              itemCount: dataSnapShot.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                RegisteredSubject eachStudentSubject =
                    dataSnapShot.data![index];

                return GestureDetector(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(
                    5,
                    index == 0 ? 0 : 10,
                    5,
                    index == dataSnapShot.data!.length - 1 ? 16 : 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.fromARGB(255, 153, 153, 153),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          eachStudentSubject.months!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      //name
                                      Expanded(
                                        child: Text(
                                          eachStudentSubject.title! +
                                              "    " +
                                              "[" +
                                              eachStudentSubject.groups! +
                                              "]",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                deletesubjectList(eachStudentSubject.stud_reg!);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
              },
            );
          } else {
            return const Center(
              child: Text("No Registered Subject."),
            );
          }
        });
  }
}
