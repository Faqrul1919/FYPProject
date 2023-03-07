import 'package:flutter/material.dart';
import 'package:gmate/admin_model/group.dart';
import 'package:gmate/admin_model/intake.dart';
import 'package:gmate/admin_service/groupService.dart';

import '../admin_service/intakeService.dart';

class AddEditIntake extends StatefulWidget {
  var intake;
  var index;

  // ignore: use_key_in_widget_constructors
  AddEditIntake({this.intake, this.index});

  @override
  _AddEditIntakeState createState() => _AddEditIntakeState();
}

final _formKey = GlobalKey<FormState>();

class _AddEditIntakeState extends State<AddEditIntake> {
  final TextEditingController _intake = TextEditingController();

  bool editMode = false;

  add(Intake intake) async {
    await IntakeService().addIntake(intake).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Intake Added!")),
      );
      Navigator.pop(context);
    });
    //print("Cidadão Adicionado!");
  }

  update(Intake intake) async {
    await IntakeService().updateIntake(intake).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Intake Updated!")),
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
      _intake.text = widget.intake.months;
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
            title: Text(editMode ? "UPDATE INTAKE" : "ADD INTAKE"),
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
                          controller: _intake,
                          decoration: const InputDecoration(
                            hintText: 'Enter Intake',
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
                            Intake intake = Intake(
                              intake_id: widget.intake.intake_id,
                              months: _intake.text,
                            );
                            update(intake);
                          } else {
                            if (_intake.text.isEmpty) {
                              // ignore: prefer_const_constructors
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("This field is required")),
                              );
                            } else {
                              Intake intake = Intake(
                                intake_id: '',
                                months: _intake.text,
                              );
                              add(intake);
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
