import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gmate/User_API/counselor_api_conn.dart';
import 'package:gmate/User_API/student_api_conn.dart';
import 'package:gmate/couns_page/review_detail.dart';
import 'package:http/http.dart' as http;
import '../User_model/review.model.dart';

class CstudenListState extends StatelessWidget {
  Future<List<StudentDB>> getListStudent() async {
    List<StudentDB> allStudent = [];

    try {
      var res = await http.post(Uri.parse(Coun_API.getStudent));

      if (res.statusCode == 200) {
        var responseBodyOfAllStudent = jsonDecode(res.body);
        if (responseBodyOfAllStudent["success"] == true) {
          (responseBodyOfAllStudent["studentData"]).forEach((eachRecord) {
            allStudent.add(StudentDB.fromJson(eachRecord));
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Error, status code is not 200");
      }
    } catch (errorMsg) {
      print("Error:: " + errorMsg.toString());
    }

    return allStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 195, 199),
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text(
          'STUDENT LIST',
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            allItemWidget(context),
          ],
        ),
      ),
    );
  }

  allItemWidget(context) {
    return FutureBuilder(
        future: getListStudent(),
        builder: (context, AsyncSnapshot<List<StudentDB>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return const Center(
              child: Text(
                "No Student Found!",
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
                StudentDB eachStudentRecord = dataSnapShot.data![index];

                return GestureDetector(
                  onTap: () {
                    Get.to(StudentReviewScreen(itemInfo: eachStudentRecord));
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
                                      children: [
                                        Expanded(
                                          child: Text(
                                            eachStudentRecord.studentname!,
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
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Email: " +
                                                eachStudentRecord.email!,
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
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Student ID:" +
                                                eachStudentRecord.student_id!,
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
                                      height: 2,
                                    ),

                                    Row(
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Semester:" +
                                                eachStudentRecord.semester!,
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
                                      height: 2,
                                    ),

                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: eachStudentRecord
                                                      .avg_rating ==
                                                  null
                                              ? 0
                                              : double.parse(eachStudentRecord
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
                                          onRatingUpdate: (updateRating) {},
                                          ignoreGestures: true,
                                          unratedColor: Colors.white,
                                          itemSize: 18,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${eachStudentRecord.avg_rating == null ? '0' : '(${eachStudentRecord.avg_rating.toString()})'}',
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

                            //image clothes
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_circle_right,
                                  color: Color.fromARGB(255, 0, 18, 99),
                                  size: 35,
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
                padding: EdgeInsets.only(left: 16, top: 200, right: 16),
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
