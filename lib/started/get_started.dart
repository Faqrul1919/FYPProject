import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmate/admin/a_login.dart';
import 'package:gmate/counselor/c_login.dart';
import 'package:gmate/bse_student/login.dart';

class GetStartedState extends StatefulWidget {
  const GetStartedState({Key? key}) : super(key: key);

  @override
  createState() => GetStarted();
}

class GetStarted extends State<GetStartedState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF424242),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/gmate_logo.png',
              height: 250,
              width: 250,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentLoginState()),
                  );
                },
                child: Text('STUDENT'),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 17),
                    primary: Colors.grey,
                    fixedSize: const Size(210, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CounselorLoginState()),
                );
              },
              child: Text('COUNSELOR'),
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.grey,
                  fixedSize: const Size(210, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => admin()),
                );
              },
              child: Text('ADMIN'),
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.grey,
                  fixedSize: const Size(210, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            )
          ],
        ),
      ),
    );
  }
}
