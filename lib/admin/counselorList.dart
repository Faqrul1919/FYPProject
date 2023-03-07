import 'package:flutter/material.dart';
import 'package:gmate/admin/CRUDStudentpage.dart';
import 'package:gmate/admin_model/counselor.dart';
import 'package:gmate/admin_model/student.dart';
import 'package:gmate/admin_service/studentService.dart';

import '../admin_service/counselorService.dart';
import 'CRUDCounselorpage.dart';

class CounselorList extends StatefulWidget {
  @override
  _CounselorListState createState() => _CounselorListState();
}

class _CounselorListState extends State<CounselorList> {
  late List<Counselor> counselorlist;

  bool loading = true;

  getAllCounselor() async {
    counselorlist = await CounselorService().getCounselor();
    setState(() {
      loading = false;
    });
    //  print("itens : ${itensList.length}");
  }

  delete(Counselor couns) async {
    await CounselorService().deleteCounselor(couns);
    setState(() {
      loading = false;
      getAllCounselor();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text("Counselor Deleted")),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllCounselor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        automaticallyImplyLeading: false,
        title: Text('Counselor List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditCounselor(),
                ),
              ).then((value) => getAllCounselor());
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
                itemCount: counselorlist.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  Counselor couns = counselorlist[i];
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
                            builder: (context) => AddEditCounselor(
                              couns: couns,
                              index: i,
                            ),
                          ),
                        ).then((value) => AddEditCounselor());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text('${couns.counselor_name[0]}' +
                            '${couns.counselor_name[couns.counselor_name.length - 1]}'),
                      ),
                      title: Text(couns.counselor_name),
                      subtitle: Text(couns.counselorID),
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
                                delete(couns);
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
