import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sistem_kearsipan/environtment.dart';
import 'package:sistem_kearsipan/environtment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginRepo {
  Future<dynamic> authenticate(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http
          .post(Uri.parse("${Base_Url}/auth/login"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, body: {
        "username": username,
        "password": password
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        prefs.setString("token", jsonResponse["token"]);
        String token = jsonResponse["token"];
        return token;
      } else {
        print("error" + response.body);
        throw Exception(json.decode(response.body));
      }
    } catch (e) {
      throw Exception("Failed connect to api ${e}");
    }
  }

  static Future<dynamic> getuserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      var response = http.post(Uri.parse("${Base_Url}/getdata"),
          headers: <String, String>{'Authorization': 'Bearer ${token}'});
      return response;
    } catch (e) {
      throw Exception("Failed get data user ${e}");
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
