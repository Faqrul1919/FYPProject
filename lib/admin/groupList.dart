import 'package:gmate/admin/CRUDGrouppage.dart';
import 'package:gmate/admin_model/group.dart';
import 'package:gmate/admin_service/groupService.dart';
import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  late List<Groups> grouplist;

  bool loading = true;

  getAllGroups() async {
    grouplist = await GroupService().getGroup();
    setState(() {
      loading = false;
    });
    //  print("itens : ${itensList.length}");
  }

  delete(Groups groups) async {
    await GroupService().deleteGroup(groups);
    setState(() {
      loading = false;
      getAllGroups();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text("Subject Deleted")),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        automaticallyImplyLeading: false,
        title: Text('Groups Class List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditGroup(),
                ),
              ).then((value) => getAllGroups());
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
                itemCount: grouplist.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  Groups groups = grouplist[i];
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
                            builder: (context) => AddEditGroup(
                              groups: groups,
                              index: i,
                            ),
                          ),
                        ).then((value) => getAllGroups());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text('${groups.groups[0]}' +
                            '${groups.groups[groups.groups.length - 1]}'),
                      ),
                      title: Text(groups.groups),
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
                                delete(groups);
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
