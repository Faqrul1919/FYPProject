import 'dart:convert';
import 'package:gmate/admin_model/student.dart';
import 'package:http/http.dart' as http;

class StudentService {
  static const ADD_URL =
      'http://192.168.100.16/gmatedb/adminStudentList/addstud.php';
  static const VIEW_URL =
      'http://192.168.100.16/gmatedb/adminStudentList/viewstud.php';
  static const UPDATE_URL =
      'http://192.168.100.16/gmatedb/adminStudentList/updatestud.php';
  static const DELETE_URL =
      'http://192.168.100.16/gmatedb/adminStudentList/deletestud.php';

  Future<String> addStudent(Student stud) async {
    final response =
        await http.post(Uri.parse(ADD_URL), body: stud.toJsonAdd());

    if (response.statusCode == 200) {
      print("success");
      //print("Update Response : " + response.body);
      return response.body;
    } else {
      //print("fail");
      return "ERROR";
    }
  }

  List<Student> subjectFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Student>.from(data.map((stud) => Student.fromjson(stud)));
  }

  Future<List<Student>> getStudent() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<Student> list = subjectFromJson(response.body);
      return list;
    } else {
      return <Student>[];
    }
  }

  Future<String> updateStudent(Student stud) async {
    final response =
        await http.post(Uri.parse(UPDATE_URL), body: stud.toJsonUpdate());

    if (response.statusCode == 200) {
      print("success");
      //print("Update Response : " + response.body);
      return response.body;
    } else {
      return "ERROR";
    }
  }

  Future<String> deleteStudent(Student stud) async {
    final response =
        await http.post(Uri.parse(DELETE_URL), body: stud.toJsonUpdate());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
