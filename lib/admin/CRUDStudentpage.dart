import 'package:flutter/material.dart';
import 'package:gmate/admin_model/student.dart';
import 'package:gmate/admin_service/studentService.dart';

class AddEditStudent extends StatefulWidget {
  var stud;
  var index;

  // ignore: use_key_in_widget_constructors
  AddEditStudent({this.stud, this.index});

  @override
  _AddEditStudentState createState() => _AddEditStudentState();
}

final _formKey = GlobalKey<FormState>();

class _AddEditStudentState extends State<AddEditStudent> {
  final TextEditingController _studentname = TextEditingController();
  final TextEditingController _student_id = TextEditingController();
  final TextEditingController _semester = TextEditingController();
  final TextEditingController _phone_num = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passwords = TextEditingController();

  bool editMode = false;
  bool _isObscure = true;

  add(Student stud) async {
    await StudentService().addStudent(stud).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student Added!")),
      );
      Navigator.pop(context);
    });
    //print("Cidadão Adicionado!");
  }

  update(Student stud) async {
    await StudentService().updateStudent(stud).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student Updated!")),
      );
      Navigator.pop(context);
    });
    //print("Cidadão Adicionado!");
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      _studentname.text = widget.stud.studentname;
      _student_id.text = widget.stud.student_id;
      _semester.text = widget.stud.semester;
      _phone_num.text = widget.stud.phone_num;
      _email.text = widget.stud.email;
      _passwords.text = widget.stud.passwords;
      bool _isObscure = true;
    }
  }

  double displayHeight() => MediaQuery.of(context).size.height;
  double displayWidth() => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: Text(editMode ? "UPDATE STUDENT" : "ADD STUDENT"),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _studentname,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Student Name',
                            hintText: 'Enter Student Name',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _student_id,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Student ID',
                            hintText: 'Enter Student ID',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _semester,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Semester',
                            hintText: 'Enter Student Semester',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _phone_num,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Phone Number',
                            hintText: 'Enter Student Phone Number',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _email,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'Email',
                            hintText: 'Enter Student Email',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          obscureText: _isObscure,
                          textAlign: TextAlign.center,
                          controller: _passwords,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            fillColor: Colors.white,
                            labelText: 'Password',
                            hintText: 'Enter Student Password',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (editMode) {
                            Student stud = Student(
                              acc_id: widget.stud.acc_id,
                              studentname: _studentname.text,
                              student_id: _student_id.text,
                              semester: _semester.text,
                              phone_num: _phone_num.text,
                              email: _email.text,
                              passwords: _passwords.text,
                            );
                            update(stud);
                          } else {
                            if (_studentname.text.isEmpty &&
                                _student_id.text.isEmpty &&
                                _semester.text.isEmpty &&
                                _email.text.isEmpty &&
                                _passwords.text.isEmpty) {
                              // ignore: prefer_const_constructors
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("This field is required")),
                              );
                            } else {
                              Student stud = Student(
                                acc_id: '',
                                studentname: _studentname.text,
                                student_id: _student_id.text,
                                semester: _semester.text,
                                phone_num: _phone_num.text,
                                email: _email.text,
                                passwords: _passwords.text,
                              );
                              add(stud);
                            }
                          }
                        },
                        child: Text(editMode ? "UPDATE " : "ADD "),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
