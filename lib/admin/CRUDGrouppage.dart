import 'package:flutter/material.dart';
import 'package:gmate/admin_model/group.dart';
import 'package:gmate/admin_service/groupService.dart';

class AddEditGroup extends StatefulWidget {
  var groups;
  var index;

  // ignore: use_key_in_widget_constructors
  AddEditGroup({this.groups, this.index});

  @override
  _AddEditGroupState createState() => _AddEditGroupState();
}

final _formKey = GlobalKey<FormState>();

class _AddEditGroupState extends State<AddEditGroup> {
  final TextEditingController _groups = TextEditingController();

  bool editMode = false;

  add(Groups groups) async {
    await GroupService().addGroup(groups).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subject Added!")),
      );
      Navigator.pop(context);
    });
    //print("Cidadão Adicionado!");
  }

  update(Groups groups) async {
    await GroupService().updateGroup(groups).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Subject Updated!")),
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
      _groups.text = widget.groups.groups;
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
            title: Text(editMode ? "UPDATE GROUP" : "ADD GROUP"),
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
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(80),
                          ),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: _groups,
                          decoration: const InputDecoration(
                            hintText: 'Enter Class Group',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(
                      //       bottom: 15, left: 10, right: 10),
                      //   child: TextFormField(
                      //     textAlign: TextAlign.center,
                      //     controller: _groups,
                      //     decoration: const InputDecoration(
                      //       fillColor: Colors.white,
                      //       labelText: 'Enter Class Group',
                      //       border: OutlineInputBorder(),
                      //       errorBorder: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Colors.red, width: 5),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (editMode) {
                            Groups groups = Groups(
                              group_id: widget.groups.group_id,
                              groups: _groups.text,
                            );
                            update(groups);
                          } else {
                            if (_groups.text.isEmpty) {
                              // ignore: prefer_const_constructors
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("This field is required")),
                              );
                            } else {
                              Groups groups = Groups(
                                group_id: '',
                                groups: _groups.text,
                              );
                              add(groups);
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
