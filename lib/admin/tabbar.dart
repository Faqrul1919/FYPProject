import 'package:flutter/material.dart';

import 'adminStudentList.dart';
import 'counselorList.dart';

class TabUser extends StatelessWidget {
  final upperTab = const TabBar(tabs: <Tab>[
    Tab(icon: Icon(Icons.badge)),
    Tab(icon: Icon(Icons.badge)),
  ]);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF424242),
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TabBar(
                indicatorColor: Colors.white,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Tab(
                        icon: Icon(Icons.badge),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Student")
                    ],
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Tab(
                        icon: Icon(Icons.badge),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Counselor")
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AStudentList(),
            CounselorList(),
          ],
        ),
      ),
    );
  }
}
