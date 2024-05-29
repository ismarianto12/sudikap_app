import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class datamaster {
  //

  static Future<dynamic> getmasterdata(String tipe) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String Url = "";
    switch (tipe) {
      case 'tipe_surat':
        Url = "/tipesurat/list";
      case 'tipe_datadinas':
        Url = "datadinas/list";
      case 'tipe_disposisi':
        Url = "";
    }
    var response = await http.post(Uri.parse(Url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("can't get master data");
    }
  }
}
