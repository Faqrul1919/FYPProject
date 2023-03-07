import 'package:flutter/material.dart';
import 'package:gmate/admin_model/student.dart';
import 'package:gmate/admin_service/studentService.dart';

import '../admin_model/counselor.dart';
import '../admin_service/counselorService.dart';

class AddEditCounselor extends StatefulWidget {
  var couns;
  var index;

  // ignore: use_key_in_widget_constructors
  AddEditCounselor({this.couns, this.index});

  @override
  _AddEditCounselorState createState() => _AddEditCounselorState();
}

final _formKey = GlobalKey<FormState>();

class _AddEditCounselorState extends State<AddEditCounselor> {
  final TextEditingController _counsname = TextEditingController();
  final TextEditingController _couns_id = TextEditingController();
  final TextEditingController _couns_room = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passwords = TextEditingController();

  bool editMode = false;
  bool _isObscure = true;

  add(Counselor couns) async {
    await CounselorService().addCounselor(couns).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Counselor Added!")),
      );
      Navigator.pop(context);
    });
    //print("Cidadão Adicionado!");
  }

  update(Counselor couns) async {
    await CounselorService().updateCounselor(couns).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Counselor Updated!")),
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
      _counsname.text = widget.couns.counselor_name;
      _couns_id.text = widget.couns.counselorID;
      _couns_room.text = widget.couns.counselor_room;
      _email.text = widget.couns.email;
      _passwords.text = widget.couns.passwords;
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
            title: Text(editMode ? "UPDATE COUNSELOR" : "ADD COUNSELOR"),
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
                          controller: _counsname,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Counselor Name',
                            hintText: 'Enter Counselor Name',
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
                          controller: _couns_id,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Counselor ID',
                            hintText: 'Enter Counselor ID',
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
                          controller: _couns_room,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Counselor Room',
                            hintText: 'Enter Counselor Room',
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
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            hintText: 'Enter Counselor Email',
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
                            filled: true,
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
                            Counselor couns = Counselor(
                              counselor_id: widget.couns.counselor_id,
                              counselor_name: _counsname.text,
                              counselorID: _couns_id.text,
                              counselor_room: _couns_room.text,
                              email: _email.text,
                              passwords: _passwords.text,
                            );
                            update(couns);
                          } else {
                            if (_counsname.text.isEmpty &&
                                _couns_id.text.isEmpty &&
                                _couns_room.text.isEmpty &&
                                _email.text.isEmpty &&
                                _passwords.text.isEmpty) {
                              // ignore: prefer_const_constructors
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("This field is required")),
                              );
                            } else {
                              Counselor couns = Counselor(
                                counselor_id: '',
                                counselor_name: _counsname.text,
                                counselorID: _couns_id.text,
                                counselor_room: _couns_room.text,
                                email: _email.text,
                                passwords: _passwords.text,
                              );
                              add(couns);
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
