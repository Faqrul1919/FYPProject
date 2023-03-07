// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmate/Gmate_page/student_list.dart';
import 'package:http/http.dart' as http;

class SearchState extends StatefulWidget {
  const SearchState({Key? key}) : super(key: key);

  @override
  StudentSearch createState() => StudentSearch();
}

class StudentSearch extends State<SearchState> {
  String? selectedSubject;

  List subList = [];

  Future getSubject() async {
    var url = "http://192.168.100.16/gmatedb/prof_sub.php";
    var response = await http.get(Uri.parse(url));
    var jsonbody = response.body;
    var jsonDatas = json.decode(jsonbody);
    setState(() {
      subList = jsonDatas;
    });

    print(jsonDatas);
    return "success";
  }

  String? selectedGroup;

  List gList = [];

  Future getGroup() async {
    var url = "http://192.168.100.16/gmatedb/prof_group.php";
    var response = await http.get(Uri.parse(url));
    var jsonbody = response.body;
    var jsonData = json.decode(jsonbody);
    setState(() {
      gList = jsonData;
    });

    print(jsonData);
    return "success";
  }

  String? selectedIntake;

  List iList = [];

  Future getIntake() async {
    var url = "http://192.168.100.16/gmatedb/prof_intake.php";
    var response = await http.get(Uri.parse(url));
    var jsonbody = response.body;
    var jsonData = json.decode(jsonbody);
    setState(() {
      iList = jsonData;
    });

    print(jsonData);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    getSubject();
    getGroup();
    getIntake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEFF1),
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text(
          'SEARCH',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 60, right: 16),
        child: ListView(
          children: [
            Text(
              "Searching",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
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
                              "assets/images/search.png",
                            ))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton2(
                  hint: Center(
                    child: Text(
                      'Select Subject',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  value: selectedSubject,
                  items: subList.map((subject) {
                    return DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Center(
                                child: Visibility(
                              child: Text(
                                subject['subject_id'],
                              ),
                              visible: false,
                            )),
                            Expanded(
                                child: Text(
                              subject['title'],
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                        value: subject['subject_id']);
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSubject = value as String?;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 350,
                  itemHeight: 40,
                  isExpanded: true,
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 150,
                  dropdownWidth: 350,
                  dropdownPadding: null,
                ),
                SizedBox(
                  height: 35,
                ),
                DropdownButton2(
                  hint: Center(
                    child: Text(
                      'Select Group',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  value: selectedGroup,
                  items: gList.map((group) {
                    return DropdownMenuItem(
                      child: Center(
                          child: Row(
                        children: [
                          Visibility(
                            child: Text(group['group_id']),
                            visible: false,
                          ),
                          Text(
                            group['groups'],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                      value: group['group_id'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGroup = value as String?;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 150,
                  itemHeight: 40,
                  isExpanded: true,
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 150,
                  dropdownWidth: 150,
                  dropdownPadding: null,
                ),
                SizedBox(
                  height: 35,
                ),
                DropdownButton2(
                  hint: Center(
                    child: Text(
                      'Select Intake',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  value: selectedIntake,
                  items: iList.map((intake) {
                    return DropdownMenuItem(
                      child: Center(
                          child: Row(
                        children: [
                          Visibility(
                            child: Text(intake['intake_id']),
                            visible: false,
                          ),
                          Text(
                            intake['months'],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                      value: intake['intake_id'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedIntake = value as String?;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 250,
                  itemHeight: 40,
                  isExpanded: true,
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 150,
                  dropdownWidth: 250,
                  dropdownPadding: null,
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  onPressed: () {
                    Get.to(
                      StudentSearchState(
                          selectedSubjectsID: selectedSubject,
                          selectedGroupsID: selectedGroup,
                          selectedIntakesID: selectedIntake),
                    );
                  },
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Search",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
