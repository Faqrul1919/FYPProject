import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gmate/couns_page/review_detail.dart';
import 'package:http/http.dart' as http;
import '../User_API/counselor_api_conn.dart';
import '../User_model/counselor_fav.dart';
import '../User_model/review.model.dart';
import '../sharedpreference/current_user.dart';

class CounsChatState extends StatefulWidget {
  @override
  State<CounsChatState> createState() => _CounsChatState();
}

class _CounsChatState extends State<CounsChatState> {
  final currentOnlineCounselor = Get.put(CurrentUser());

  Future<List<C_Favourite>> getCurrentCounselorFavoriteList() async {
    List<C_Favourite> favoriteListOfCounselor = [];

    try {
      var res = await http.post(Uri.parse(Coun_API.readFavorite), body: {
        "counselor_id": currentOnlineCounselor.user2.counselor_id.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyOfCurrentUserFavoriteListItems = jsonDecode(res.body);

        if (responseBodyOfCurrentUserFavoriteListItems['success'] == true) {
          (responseBodyOfCurrentUserFavoriteListItems['counselorFavoriteData']
                  as List)
              .forEach((eachCurrentUserFavoriteItemData) {
            favoriteListOfCounselor
                .add(C_Favourite.fromJson(eachCurrentUserFavoriteItemData));
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error:: " + errorMsg.toString());
    }

    return favoriteListOfCounselor;
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
            child: counselortfavWidget(),
          ),
        ],
      ),
    );
  }

  counselortfavWidget() {
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

            Align(child: favoriteListCounselorWidget(context))
          ],
        ),
      ),
    );
  }

  favoriteListCounselorWidget(context) {
    return FutureBuilder(
        future: getCurrentCounselorFavoriteList(),
        builder: (context, AsyncSnapshot<List<C_Favourite>> dataSnapShot) {
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
                C_Favourite eachFavoriteCounselorRecord =
                    dataSnapShot.data![index];
                StudentDB clickedStudentData = StudentDB(
                  acc_id: eachFavoriteCounselorRecord.acc_id,
                  studentname: eachFavoriteCounselorRecord.studentname,
                  student_id: eachFavoriteCounselorRecord.student_id,
                  semester: eachFavoriteCounselorRecord.semester,
                  phone_num: eachFavoriteCounselorRecord.phone_num,
                  email: eachFavoriteCounselorRecord.email,
                  avg_rating: eachFavoriteCounselorRecord.avg_rating,
                );

                return GestureDetector(
                  onTap: () {
                    Get.to(StudentReviewScreen(itemInfo: clickedStudentData));
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
                                            eachFavoriteCounselorRecord
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
                                    Row(
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Email: " +
                                                eachFavoriteCounselorRecord
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
                                    Row(
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Student ID: " +
                                                eachFavoriteCounselorRecord
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
                                    Row(
                                      children: [
                                        //name
                                        Expanded(
                                          child: Text(
                                            "Semester: " +
                                                eachFavoriteCounselorRecord
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
                                              eachFavoriteCounselorRecord
                                                          .avg_rating ==
                                                      null
                                                  ? 0
                                                  : double.parse(
                                                      eachFavoriteCounselorRecord
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
                                          itemSize: 20,
                                        ),

                                        const SizedBox(
                                          width: 8,
                                        ),

                                        //rating num
                                        Text(
                                          '${eachFavoriteCounselorRecord.avg_rating == null ? '0' : '(${eachFavoriteCounselorRecord.avg_rating.toString()})'}',
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
