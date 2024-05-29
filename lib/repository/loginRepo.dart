import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:sistem_kearsipan/environtment.dart';
import 'package:sistem_kearsipan/environtment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginRepo {
  Future<dynamic> authenticate(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // try {
    var response = await http.post(Uri.parse("${Base_Url}login"),
        body: {"username": username, "password": password});
    print('status login ${response}');
    var jsonResponse = json.decode(response.body);
    Bool status = jsonResponse["success"];
    if (response.statusCode == 200) {
      prefs.setString("token", jsonResponse["accessToken"]);
      Bool status = jsonResponse["success"];
      return status;
    } else {
      // print("error" + response.body);
      // throw Exception(json.decode(response.body));
      return status;
    }
    // } catch (e) {
    //   print("error" + e.toString());
    //   throw Exception("Failed connect to api ${e}");
    // }
  }

  static Future<dynamic> loginApi(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.post(Uri.parse("${Base_Url}login"),
          body: {"username": username, "password": password});
      var jsonResponse = json.decode(response.body);
      // Bool status = jsonResponse["success"];
      if (response.statusCode == 200) {
        prefs.setString("token", jsonResponse["accessToken"]);
        // Bool status = jsonResponse["success"];
        return jsonResponse;
      } else {
        // print("error" + response.body);
        // throw Exception(json.decode(response.body));
        return jsonResponse;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // static Future<dynamic> getProfile() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? token = pref.getString("token");
  //   try {
  //     var response = http.post(Uri.parse("${Base_Url}/getdata"))
  //   } catch (e) {

  //   }
  // }

  static Future<dynamic> getuserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      var response = await http.post(Uri.parse("${Base_Url}/getdata"),
          headers: <String, String>{'Authorization': 'Bearer ${token}'});
      if (response.statusCode == 200) {
        var data = json.decode(response.body)[0];
        return data;
      }
    } catch (e) {
      throw Exception("Failed get data user ${e}");
    }
  }

  // static Future<dynamic> updatePassword(
  //     String username, String password) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString("token");
  //   try {
  //     var response = await http.post(
  //       Uri.parse("${Base_Url}/updatepassword"),
  //       headers: <String, String>{'Authorization': 'Bearer ${token}'},
  //       body: {username: username, password: password},
  //     );
  //     return response.body;
  //   } catch (e) {
  //     throw Exception("Failed get data user ${e}");
  //   }
  // }
  static Future<dynamic> updatePassword(
      String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      var response = await http.post(Uri.parse("${Base_Url}updatepassword"),
          headers: <String, String>{'Authorization': '${token}'},
          body: {"username": username, "password": password});
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        return jsonResponse;
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  Future<dynamic> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("token");
  }

  // get data user
  Future<dynamic> getdatauser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var response = await http.post(Uri.parse("${Base_Url}getProfile"),
        headers: <String, String>{'Authrization': 'Bearer ${token}'});
    if (response.statusCode == 200) {
      var datajson = json.decode(response.body);
    } else {
      var datajson = [];
    }
  }

  Future<dynamic> saveProfile(
    String email,
    String passwordbaru,
    String password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      var response = await http.post(
        Uri.parse("${Base_Url}saveProfile"),
        headers: <String, String>{'Authorization': 'Bearer ${token}'},
        body: json.encode(
          {
            'email': email,
            'password': password,
            'passwordbaru': passwordbaru,
          },
        ),
      );
      return response.statusCode;
    } catch (e) {
      throw Exception("Failed update data user ${e}");
    }
  }
}
