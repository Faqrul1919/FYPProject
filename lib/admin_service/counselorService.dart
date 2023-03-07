import 'dart:convert';
import 'package:gmate/admin_model/counselor.dart';
import 'package:gmate/admin_model/student.dart';
import 'package:http/http.dart' as http;

class CounselorService {
  static const ADD_URL =
      'http://192.168.100.16/gmatedb/adminCounselorList/addC.php';
  static const VIEW_URL =
      'http://192.168.100.16/gmatedb/adminCounselorList/viewC.php';
  static const UPDATE_URL =
      'http://192.168.100.16/gmatedb/adminCounselorList/updateC.php';
  static const DELETE_URL =
      'http://192.168.100.16/gmatedb/adminCounselorList/deleteC.php';

  Future<String> addCounselor(Counselor couns) async {
    final response =
        await http.post(Uri.parse(ADD_URL), body: couns.toJsonAdd());

    if (response.statusCode == 200) {
      print("success");
      //print("Update Response : " + response.body);
      return response.body;
    } else {
      //print("fail");
      return "ERROR";
    }
  }

  List<Counselor> CounselorFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Counselor>.from(data.map((couns) => Counselor.fromjson(couns)));
  }

  Future<List<Counselor>> getCounselor() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<Counselor> list = CounselorFromJson(response.body);
      return list;
    } else {
      return <Counselor>[];
    }
  }

  Future<String> updateCounselor(Counselor couns) async {
    final response =
        await http.post(Uri.parse(UPDATE_URL), body: couns.toJsonUpdate());

    if (response.statusCode == 200) {
      print("success");
      //print("Update Response : " + response.body);
      return response.body;
    } else {
      return "ERROR";
    }
  }

  Future<String> deleteCounselor(Counselor couns) async {
    final response =
        await http.post(Uri.parse(DELETE_URL), body: couns.toJsonUpdate());
    if (response.statusCode == 200) {
      print("success");
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
