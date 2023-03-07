import 'package:flutter/material.dart';
import 'package:gmate/admin/CRUDStudentpage.dart';
import 'package:gmate/admin_model/student.dart';
import 'package:gmate/admin_service/studentService.dart';

class AStudentList extends StatefulWidget {
  @override
  _AStudentListState createState() => _AStudentListState();
}

class _AStudentListState extends State<AStudentList> {
  late List<Student> studentlist;

  bool loading = true;

  getAllStudent() async {
    studentlist = await StudentService().getStudent();
    setState(() {
      loading = false;
    });
    //  print("itens : ${itensList.length}");
  }

  delete(Student stud) async {
    await StudentService().deleteStudent(stud);
    setState(() {
      loading = false;
      getAllStudent();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text("Student Deleted")),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        automaticallyImplyLeading: false,
        title: Text('BSE Students List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditStudent(),
                ),
              ).then((value) => getAllStudent());
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
                itemCount: studentlist.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  Student stud = studentlist[i];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditStudent(
                              stud: stud,
                              index: i,
                            ),
                          ),
                        ).then((value) => getAllStudent());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text('${stud.studentname[0]}' +
                            '${stud.studentname[stud.studentname.length - 1]}'),
                      ),
                      title: Text(stud.studentname),
                      subtitle: Text(stud.student_id),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Delete Student'),
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
                                delete(stud);
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
