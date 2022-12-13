import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gmate/User_model/review.model.dart';
import 'package:http/http.dart' as http;
import '../User_API/counselor_api_conn.dart';
import '../User_model/student_model.dart';
import '../sharedpreference/current_user.dart';
import 'favourite_controller.dart';

class StudentReviewScreen extends StatefulWidget {
  final StudentDB? itemInfo;

  StudentReviewScreen({
    this.itemInfo,
  });

  @override
  State<StudentReviewScreen> createState() => _StudentReview();
}

class _StudentReview extends State<StudentReviewScreen> {
  final itemDetailsController = Get.put(ItemDetailsController());
  final currentOnlineCounselor = Get.put(CurrentUser());

  _launchWhatsapp() async {
    var whatsapp = widget.itemInfo!.phone_num!;
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text=Hello, my name is ,\n I'm counselor for Unikl MIIT.");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  Future<List<Review>> getReviewList() async {
    List<Review> reviewList = [];

    try {
      var res = await http.post(Uri.parse(Coun_API.getReview), body: {
        "acc_id": widget.itemInfo!.acc_id.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyOfCurrentUserReviewListItems = jsonDecode(res.body);

        if (responseBodyOfCurrentUserReviewListItems['success'] == true) {
          (responseBodyOfCurrentUserReviewListItems['studentReviewData']
                  as List)
              .forEach((eachCurrentUserReviewItemData) {
            reviewList.add(Review.fromJson(eachCurrentUserReviewItemData));
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error:: " + errorMsg.toString());
    }

    return reviewList;
  }

  Future<List<RegisteredSubject>> getStudentSubjectList() async {
    List<RegisteredSubject> subjectList = [];

    try {
      var res = await http.post(Uri.parse(Coun_API.readStudSubj), body: {
        "acc_id": widget.itemInfo!.acc_id.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyOfCurrentUserFavoriteListItems = jsonDecode(res.body);

        if (responseBodyOfCurrentUserFavoriteListItems['success'] == true) {
          (responseBodyOfCurrentUserFavoriteListItems['studentSubjectData']
                  as List)
              .forEach((eachCurrentUserFavoriteItemData) {
            subjectList.add(
                RegisteredSubject.fromJson(eachCurrentUserFavoriteItemData));
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

  validateFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(Coun_API.validateFavorite),
        body: {
          "counselor_id": currentOnlineCounselor.user2.counselor_id.toString(),
          "acc_id": widget.itemInfo!.acc_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfValidateFavorite = jsonDecode(res.body);
        if (resBodyOfValidateFavorite['favoriteFound'] == true) {
          itemDetailsController.setIsFavorite(true);
        } else {
          itemDetailsController.setIsFavorite(false);
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  addItemToFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(Coun_API.addFavorite),
        body: {
          "counselor_id": currentOnlineCounselor.user2.counselor_id.toString(),
          "acc_id": widget.itemInfo!.acc_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfAddFavorite = jsonDecode(res.body);
        if (resBodyOfAddFavorite['success'] == true) {
          Fluttertoast.showToast(
              msg: "item saved to your Favorite List Successfully.");

          validateFavoriteList();
        } else {
          Fluttertoast.showToast(msg: "Item not saved to your Favorite List.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  deleteItemFromFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(Coun_API.deleteFavorite),
        body: {
          "counselor_id": currentOnlineCounselor.user2.counselor_id.toString(),
          "acc_id": widget.itemInfo!.acc_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfDeleteFavorite = jsonDecode(res.body);
        if (resBodyOfDeleteFavorite['success'] == true) {
          Fluttertoast.showToast(msg: "item Deleted from your Favorite List.");

          validateFavoriteList();
        } else {
          Fluttertoast.showToast(
              msg: "item NOT Deleted from your Favorite List.");
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

    validateFavoriteList();
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              elevation: 4,
              color: Colors.green,
              borderRadius: BorderRadius.circular(0),
              child: InkWell(
                //link through whatapp
                onTap: () {
                  _launchWhatsapp();
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.whatsapp,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "WhatApps",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

                const Spacer(),

                //favorite
                Obx(() => IconButton(
                      onPressed: () {
                        if (itemDetailsController.isFavorite == true) {
                          //delete item from favorites
                          deleteItemFromFavoriteList();
                        } else {
                          //save item to user favorites
                          addItemToFavoriteList();
                        }
                      },
                      icon: Icon(
                        itemDetailsController.isFavorite
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  studentReviewWidget() {
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
              height: 18,
            ),

            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //name
            Text(
              widget.itemInfo!.studentname!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 21,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              "Student ID: " + widget.itemInfo!.student_id!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              "Semester: " + widget.itemInfo!.semester!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "Phone Number: " + widget.itemInfo!.phone_num!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),

            Text(
              "Email: " + widget.itemInfo!.email!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //rating + rating num
                      Row(
                        children: [
                          //rating bar
                          RatingBar.builder(
                            initialRating: 3.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, c) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (updateRating) {},
                            ignoreGestures: true,
                            unratedColor: Colors.grey,
                            itemSize: 20,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          //rating num
                          Text(
                            "3.5",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Subject",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              child: studentSubjectWidget(context),
            ),
            const SizedBox(height: 10),
            Divider(
              height: 1,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Review",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              child: commentNratingWidget(context),
            ),
            const SizedBox(
              height: 43,
            ),
            //add to cart button
          ],
        ),
      ),
    );
  }

  commentNratingWidget(context) {
    return FutureBuilder(
        future: getReviewList(),
        builder: (context, AsyncSnapshot<List<Review>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return const Center(
              child: Text(
                "No Review",
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
                Review eachStudentRecord = dataSnapShot.data![index];

                return GestureDetector(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(
                    0,
                    index == 0 ? 0 : 0,
                    0,
                    index == dataSnapShot.data!.length - 1 ? 16 : 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Color.fromARGB(255, 143, 138, 138),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Row(
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
                                children: const [
                                  //name
                                  Expanded(
                                    child: Text(
                                      "Anonymous : ",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: eachStudentRecord.rating!,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, c) => const Icon(
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
                                    "(" +
                                        eachStudentRecord.rating.toString() +
                                        ")",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  //name
                                  Expanded(
                                    child: Text(
                                      "Comment : \n" +
                                          eachStudentRecord.comments!,
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
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              },
            );
          } else {
            return const Center(
              child: Text("No Review."),
            );
          }
        });
  }

  studentSubjectWidget(context) {
    return FutureBuilder(
        future: getStudentSubjectList(),
        builder:
            (context, AsyncSnapshot<List<RegisteredSubject>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return const Center(
              child: Text(
                "No Review",
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
                RegisteredSubject eachStudentRecord = dataSnapShot.data![index];

                return GestureDetector(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(
                    0,
                    index == 0 ? 0 : 0,
                    0,
                    index == dataSnapShot.data!.length - 1 ? 16 : 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Color.fromARGB(255, 143, 138, 138),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Row(
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
                                  //name
                                  Expanded(
                                    child: Text(
                                      eachStudentRecord.months! +
                                          "\n" +
                                          eachStudentRecord.title! +
                                          "  " +
                                          "[" +
                                          eachStudentRecord.groups! +
                                          "]",
                                      style: TextStyle(
                                        fontSize: 14,
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
