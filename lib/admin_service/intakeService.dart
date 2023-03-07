import 'dart:convert';
import 'package:http/http.dart' as http;
import '../admin_model/intake.dart';

class IntakeService {
  static const ADD_URL =
      'http://192.168.100.16/gmatedb/adminIntake/addintake.php';
  static const VIEW_URL =
      'http://192.168.100.16/gmatedb/adminIntake/viewintake.php';
  static const UPDATE_URL =
      'http://192.168.100.16/gmatedb/adminIntake/updateintake.php';
  static const DELETE_URL =
      'http://192.168.100.16/gmatedb/adminIntake/deleteintake.php';

  Future<String> addIntake(Intake intake) async {
    final response =
        await http.post(Uri.parse(ADD_URL), body: intake.toJsonAdd());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }

  List<Intake> groupFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Intake>.from(data.map((intake) => Intake.fromjson(intake)));
  }

  Future<List<Intake>> getIntake() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<Intake> list = groupFromJson(response.body);
      return list;
    } else {
      return <Intake>[];
    }
  }

  Future<String> updateIntake(Intake intake) async {
    final response =
        await http.post(Uri.parse(UPDATE_URL), body: intake.toJsonUpdate());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }

  Future<String> deleteIntake(Intake intake) async {
    final response =
        await http.post(Uri.parse(DELETE_URL), body: intake.toJsonUpdate());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
