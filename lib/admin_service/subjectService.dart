import 'dart:convert';
import 'package:gmate/admin_model/subject.dart';
import 'package:http/http.dart' as http;

class SubjectService {
  static const ADD_URL =
      'http://192.168.100.16/gmatedb/adminSubject/admin_add_sub.php';
  static const VIEW_URL =
      'http://192.168.100.16/gmatedb/adminSubject/admin_sub.php';
  static const UPDATE_URL =
      'http://192.168.100.16/gmatedb/adminSubject/admin_edit_sub.php';
  static const DELETE_URL =
      'http://192.168.100.16/gmatedb/adminSubject/admin_delete_sub.php';

  Future<String> addSubject(Subject subject) async {
    final response =
        await http.post(Uri.parse(ADD_URL), body: subject.toJsonAdd());

    if (response.statusCode == 200) {
      print("success");
      //print("Update Response : " + response.body);
      return response.body;
    } else {
      //print("fail");
      return "ERROR";
    }
  }

  List<Subject> subjectFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Subject>.from(data.map((subject) => Subject.fromjson(subject)));
  }

  Future<List<Subject>> getSubject() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<Subject> list = subjectFromJson(response.body);
      return list;
    } else {
      return <Subject>[];
    }
  }

  Future<String> updateSubject(Subject subject) async {
    final response =
        await http.post(Uri.parse(UPDATE_URL), body: subject.toJsonUpdate());

    if (response.statusCode == 200) {
      print("success");
      //print("Update Response : " + response.body);
      return response.body;
    } else {
      return "ERROR";
    }
  }

  Future<String> deleteSubject(Subject subject) async {
    final response =
        await http.post(Uri.parse(DELETE_URL), body: subject.toJsonUpdate());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
