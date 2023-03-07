import 'package:gmate/admin/CRUDGrouppage.dart';
import 'package:gmate/admin_model/intake.dart';
import 'package:flutter/material.dart';

import '../admin_service/intakeService.dart';
import 'CRUDIntakepage.dart';

class IntakeList extends StatefulWidget {
  @override
  _IntakeListState createState() => _IntakeListState();
}

class _IntakeListState extends State<IntakeList> {
  late List<Intake> intakelist;

  bool loading = true;

  getAllIntake() async {
    intakelist = await IntakeService().getIntake();
    setState(() {
      loading = false;
    });
    //  print("itens : ${itensList.length}");
  }

  delete(Intake intake) async {
    await IntakeService().deleteIntake(intake);
    setState(() {
      loading = false;
      getAllIntake();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text("Intake Deleted")),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllIntake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        automaticallyImplyLeading: false,
        title: Text('Intake List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditIntake(),
                ),
              ).then((value) => getAllIntake());
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
                itemCount: intakelist.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  Intake intake = intakelist[i];
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
                            builder: (context) => AddEditIntake(
                              intake: intake,
                              index: i,
                            ),
                          ),
                        ).then((value) => getAllIntake());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text('${intake.months[0]}' +
                            '${intake.months[1]}' +
                            '${intake.months[2]}'),
                      ),
                      title: Text(intake.months),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Delete Group'),
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
                                delete(intake);
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
