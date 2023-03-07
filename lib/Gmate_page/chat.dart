import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gmate/Gmate_page/view_favourite.dart';
import 'package:gmate/couns_page/review_detail.dart';
import 'package:http/http.dart' as http;
import '../User_API/counselor_api_conn.dart';
import '../User_API/student_api_conn.dart';
import '../User_model/counselor_fav.dart';
import '../User_model/review.model.dart';
import '../User_model/student_model.dart';
import '../sharedpreference/current_user.dart';

class StudentChatState extends StatefulWidget {
  @override
  State<StudentChatState> createState() => _StudentChatState();
}

class _StudentChatState extends State<StudentChatState> {
  final currentOnlineUser = Get.put(CurrentUser());

  Future<List<Student_Favourite>> getCurrentUserFavoriteList() async {
    List<Student_Favourite> favoriteListOfStudent = [];

    try {
      var res = await http.post(Uri.parse(API.readFavorite), body: {
        "acc_id": currentOnlineUser.user.acc_id.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyOfCurrentUserFavoriteListItems = jsonDecode(res.body);

        if (responseBodyOfCurrentUserFavoriteListItems['success'] == true) {
          (responseBodyOfCurrentUserFavoriteListItems['studentFavoriteData']
                  as List)
              .forEach((eachCurrentUserFavoriteItemData) {
            favoriteListOfStudent.add(
                Student_Favourite.fromJson(eachCurrentUserFavoriteItemData));
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error:: " + errorMsg.toString());
    }

    return favoriteListOfStudent;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 72, 114),
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text(
          'FAVOURITE',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Image(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            image: AssetImage(
              "assets/images/unikl2.png",
            ),
          ),

          //item information
          Align(
            alignment: Alignment.bottomCenter,
            child: studentfavWidget(),
          ),
        ],
      ),
    );
  }

  studentfavWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.58,
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
            blurRadius: 10,
            color: Color.fromARGB(255, 98, 189, 241),
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
                'Favourite',
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

            Align(child: favoriteListUserWidget(context))
          ],
        ),
      ),
    );
  }

  favoriteListUserWidget(context) {
    return FutureBuilder(
        future: getCurrentUserFavoriteList(),
        builder:
            (context, AsyncSnapshot<List<Student_Favourite>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return const Center(
              child: Text(
                "No Student found!",
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
                Student_Favourite eachFavoriteStudentRecord =
                    dataSnapShot.data![index];

                return GestureDetector(
                  onTap: () {
                    Get.to(StudentFavoriteInformationScreen(
                        itemInfo: eachFavoriteStudentRecord));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 10,
                      16,
                      index == dataSnapShot.data!.length - 1 ? 16 : 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 153, 153, 153),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 7,
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
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //name and price
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Expanded(
                                          child: Text(
                                            eachFavoriteStudentRecord
                                                .studentname!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
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
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Email: " +
                                                eachFavoriteStudentRecord
                                                    .email!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Student ID: " +
                                                eachFavoriteStudentRecord
                                                    .student_id!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Semester: " +
                                                eachFavoriteStudentRecord
                                                    .semester!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        //rating bar
                                        RatingBar.builder(
                                          initialRating:
                                              eachFavoriteStudentRecord
                                                          .avg_rating ==
                                                      null
                                                  ? 0
                                                  : double.parse(
                                                      eachFavoriteStudentRecord
                                                          .avg_rating!),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemBuilder: (context, c) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (updatraeRating) {},
                                          ignoreGestures: true,
                                          unratedColor: Colors.white,
                                          itemSize: 20,
                                        ),

                                        const SizedBox(
                                          width: 8,
                                        ),

                                        //rating num
                                        Text(
                                          '${eachFavoriteStudentRecord.avg_rating == null ? '0' : '(${eachFavoriteStudentRecord.avg_rating.toString()})'}',
                                          style: const TextStyle(
                                            color: Colors.black,
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
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_circle_right,
                                  color: Color.fromARGB(255, 0, 18, 99),
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(left: 16, top: 100, right: 16),
                child: Container(
                  width: 200,
                  height: 200,
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
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/noData.png",
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
