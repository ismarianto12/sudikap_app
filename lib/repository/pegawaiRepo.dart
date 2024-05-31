import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_kearsipan/environtment.dart';

class PegawaiRepo {
  static Future<dynamic> getData(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}pegawai/list?page=$page';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print("Response Pegawai : ${Uri.parse(url)}");
    if (response.statusCode == 200) {
      // print(json.decode(response.body)['data']);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('${response}');
    }
  }

  static Future<dynamic> GedetailPegawai(int id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    var response = await http.post(
      Uri.parse("${Base_Url}detail/${id}"),
      headers: <String, String>{
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    } else {
      throw Exception("failed load karyawan data");
    }
  }

  // untuk surat masuk
  static Future<dynamic> getDataSuratKeluar(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}surat_keluar/list?page=$page';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<dynamic> getDataDisposisi(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}disposisi/list?page=$page';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      print("disposisi json");
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
