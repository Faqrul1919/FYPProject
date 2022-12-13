import 'package:gmate/admin_service/subjectService.dart';
import 'package:flutter/material.dart';
import 'package:gmate/admin_model/subject.dart';

class AddEditSubjects extends StatefulWidget {
  var subject;
  var index;

  AddEditSubjects({this.subject, this.index});

  @override
  _AddEditSubjectsState createState() => _AddEditSubjectsState();
}

class _AddEditSubjectsState extends State<AddEditSubjects> {
  final TextEditingController sub_codes = TextEditingController();
  final TextEditingController title = TextEditingController();

  bool editMode = false;

  add(Subject subject) async {
    await SubjectService().addSubject(subject).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subject added!")),
      );
      Navigator.pop(context);
    });
    //print("Item Adicionado!");
  }

  update(Subject subject) async {
    await SubjectService().updateSubject(subject).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subject Updated")),
      );
      Navigator.pop(context);
    });
    //  print("Item Atualizado!");
  }

  @override
  void initState() {
    super.initState();
    if (widget.subject != null) {
      editMode = true;
      title.text = widget.subject.title;
    }
  }

  double displayHeight() => MediaQuery.of(context).size.height;
  double displayWidth() => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    print(editMode);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey,
          centerTitle: true,
          title: Text(editMode ? "Update Subject" : "Add Subject"),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(80),
                        ),
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: title,
                        decoration: const InputDecoration(
                          // label: Text('TITLE'),
                          hintText: 'Subject Title',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (editMode) {
                          Subject subject = Subject(
                            sub_id: widget.subject.sub_id,
                            title: title.text,
                          );
                          update(subject);
                        } else {
                          if (sub_codes.text.isEmpty) {
                            // ignore: prefer_const_constructors
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("This field is required")),
                            );
                          } else {
                            Subject subject = Subject(
                              sub_id: '',
                              title: title.text,
                            );
                            add(subject);
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
        ));
  }
}
