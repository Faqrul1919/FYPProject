import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmate/admin_model/subject.dart';
import 'package:gmate/admin_service/subjectService.dart';
import 'package:flutter/material.dart';
import 'package:gmate/started/get_started.dart';

import 'CRUDSubjectpage.dart';

class SubjectList extends StatefulWidget {
  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  late List<Subject> subjectList;

  bool loading = true;

  getAllSubjects() async {
    subjectList = await SubjectService().getSubject();
    setState(() {
      loading = false;
    });
    //  print("itens : ${itensList.length}");
  }

  delete(Subject subject) async {
    await SubjectService().deleteSubject(subject);
    setState(() {
      loading = false;
      getAllSubjects();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text("Subject Deleted")),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        automaticallyImplyLeading: false,
        title: Text('Subjects List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditSubjects(),
                ),
              ).then((value) => getAllSubjects());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => GetStartedState()));
              Fluttertoast.showToast(
                  msg: "Successfully Logout",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black,
                  fontSize: 16.0);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: subjectList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  Subject subject = subjectList[i];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditSubjects(
                              subject: subject,
                              index: i,
                            ),
                          ),
                        ).then((value) => getAllSubjects());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text('${subject.title[0]}' +
                            '${subject.title[subject.title.length - 1]}'),
                      ),
                      title: Text(subject.title),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Delete Subject'),
                                content: Text('Are You Sure?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('NO'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                  TextButton(
                                    child: Text('YES'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                  ),
                                ],
                              ),
                            ).then((confirmed) {
                              if (confirmed) {
                                delete(subject);
                              }
                            });
                          }),
                    ),
                  );
                }),
      ),
    );
  }
}
