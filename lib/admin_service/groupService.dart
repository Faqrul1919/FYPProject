import 'dart:convert';
import '../admin_model/group.dart';
import 'package:http/http.dart' as http;

class GroupService {
  static const ADD_URL =
      'http://192.168.100.16/gmatedb/adminGroup/addgroup.php';
  static const VIEW_URL =
      'http://192.168.100.16/gmatedb/adminGroup/viewgroup.php';
  static const UPDATE_URL =
      'http://192.168.100.16/gmatedb/adminGroup/updategroup.php';
  static const DELETE_URL =
      'http://192.168.100.16/gmatedb/adminGroup/deletegroup.php';

  Future<String> addGroup(Groups groups) async {
    final response =
        await http.post(Uri.parse(ADD_URL), body: groups.toJsonAdd());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }

  List<Groups> groupFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Groups>.from(data.map((groups) => Groups.fromjson(groups)));
  }

  Future<List<Groups>> getGroup() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<Groups> list = groupFromJson(response.body);
      return list;
    } else {
      return <Groups>[];
    }
  }

  Future<String> updateGroup(Groups groups) async {
    final response =
        await http.post(Uri.parse(UPDATE_URL), body: groups.toJsonUpdate());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }

  Future<String> deleteGroup(Groups groups) async {
    final response =
        await http.post(Uri.parse(DELETE_URL), body: groups.toJsonUpdate());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
