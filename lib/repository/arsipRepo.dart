import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_kearsipan/environtment.dart';

class arsipRepo {
  static Future<dynamic> listdataArsip(int page, String searchingdata) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String url = '${Base_Url}arsip/list?page=$page&search=${searchingdata}';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
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

  static Future<dynamic> getDataDetail(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String url = '${Base_Url}arsip/detail/${id}';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<dynamic> getData(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}surat/list?page=$page';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
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

  // untuk surat masuk
  static Future<dynamic> getDataSuratKeluar(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}surat_keluar/list?page=$page';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
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

  static Future<dynamic> createArchive(
    String _namaArsipController,
    String _jumlahController,
    String _keteranganController,
    String _id_satuanController,
    String _id_jenisController,
    String _id_pejabatController,
  ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var response = await http.post(
        Uri.parse("${Base_Url}arsip/insert"),
        headers: <String, String>{'Authorization': 'Bearer $token'},
        body: {
          'nama': _namaArsipController,
          'jumlah': _jumlahController,
          'keterangan': _keteranganController,
          'id_satuan': _id_satuanController,
          'id_jenis': _id_jenisController, // Fixed this line
          'id_pejabat': _id_pejabatController, // Fixed this line
        },
      );
      print(response);
      print("${Base_Url}/arsip/insert");
      return response;
    } catch (e) {
      throw Exception('Failed to insert data');
    }
  }

  static Future<dynamic> updateArchive(
    int idarsip,
    String _namaArsipController,
    String _jumlahController,
    String _keteranganController,
    String _id_satuanController,
    String _id_jenisController,
    String _id_pejabatController,
  ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      var response = await http.post(
        Uri.parse("${Base_Url}arsip/update/${idarsip}"),
        headers: <String, String>{'Authorization': 'Bearer $token'},
        body: {
          'nama': _namaArsipController,
          'jumlah': _jumlahController,
          'keterangan': _keteranganController,
          'id_satuan': _id_satuanController,
          'id_jenis': _id_jenisController, // Fixed this line
          'id_pejabat': _id_pejabatController, // Fixed this line
        },
      );
      print(response);
      print("${Base_Url}/arsip/update");
      return response;
    } catch (e) {
      throw Exception('Failed to insert data');
    }
  }
}


// action create acrvhice 