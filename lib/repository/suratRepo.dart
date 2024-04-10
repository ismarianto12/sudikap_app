import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_kearsipan/environtment.dart';

import 'dart:io';

class SuratRepo {
  static Future<dynamic> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  static Future<dynamic> getData(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}surat/list?page=$page';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token!,
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
      //print(json.decode(response.body)['data']);
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

  static Future<dynamic> searchData(String q) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}surat_masuksearch';
    var response = await http.post(Uri.parse(url), headers: <String, String>{
      'Authorization': 'Bearer $token',
    }, body: {
      'q': q
    });
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      print("disposisi json");
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  //action surat keluar
  static Future<http.Response> createSuratkeluar(
    String _kodeController,
    String _noAgendaController,
    String _nosuratController,
    String _tujuanController,
    String _isiController,
    String _tglSuratController,
    String _keteranganController,
    String _id_jenis_surat,
    List<File> _selectedFiles,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var sendata = {
      'kode': _kodeController,
      'no_agenda': _noAgendaController,
      'no_surat': _nosuratController,
      'tujuan': _tujuanController,
      'isi_surat': _isiController,
      'tlg_surat': _tglSuratController,
      'keterangan': _keteranganController,
      'id_jenis_surat': _id_jenis_surat, // Menggunakan parameter yang diterima
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Base_Url}surat_keluar/insert'),
    );
    request.headers["Authorization"] = 'Bearer ${token}';
    request.fields.addAll(sendata);
    _selectedFiles.forEach((file) {
      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        file.readAsBytesSync(),
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    });
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    try {
      print(responseBody);
      return await http.Response.fromStream(response);
    } catch (e) {
      print('Error uploading data and file: $e');
      return http.Response('Error uploading data and file: $e', 500);
    }
  }

  static Future<http.Response> updateSuratkeluar(
    String _kodeController,
    String _noAgendaController,
    String _nosuratController,
    String _tujuanController,
    String _isiController,
    String _tglSuratController,
    String _keteranganController,
    String _id_jenis_surat,
    List<File> _selectedFiles,
    int id,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var sendata = {
      'kode': _kodeController,
      'no_agenda': _noAgendaController,
      'no_surat': _nosuratController,
      'tujuan': _tujuanController,
      'isi_surat': _isiController,
      'tlg_surat': _tglSuratController,
      'keterangan': _keteranganController,
      'id_jenis_surat': _id_jenis_surat, // Menggunakan parameter yang diterima
      'id_surat': id.toString(),
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Base_Url}surat_keluar/update/${id}'),
    );
    request.headers["Authorization"] = 'Bearer ${token}';
    request.fields.addAll(sendata);
    _selectedFiles.forEach((file) {
      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        file.readAsBytesSync(),
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    });
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    try {
      print(responseBody);
      return await http.Response.fromStream(response);
    } catch (e) {
      print('Error uploading data and file: $e');
      return http.Response('Error uploading data and file: $e', 500);
    }
    //action old version file upload ()

    // Future<void> _actionSubmitData() async {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   var sendata = {
    //     'kode': _kodeController.text,
    //     'no_agenda': _noAgendaController.text,
    //     'no_surat': _nosuratController.text,
    //     'tujuan': _tujuanController.text,
    //     'isi_surat': _isiController.text,
    //     'tlg_surat': _tglSuratController.text,
    //     'keterangan': _keteranganController.text,
    //     'id_jenis_surat': '10'
    //   };
    //   var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         'http://192.168.88.51/backend_arsip/public/api/v1/surat_keluar/insert'),
    //   );
    //   sendata.forEach((key, value) {
    //     request.fields[key] = value;
    //   });
    //   _selectedFiles.forEach((file) {
    //     var multipartFile = http.MultipartFile.fromBytes(
    //       'file',
    //       file.readAsBytesSync(),
    //       filename: file.path.split('/').last,
    //     );
    //     request.files.add(multipartFile);
    //   });
    //   try {
    //     var response = await request.send();
    //     var responseBody = await response.stream.bytesToString();
    //     if (response.statusCode == 200) {
    //       showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             title: Text("Success"),
    //             titleTextStyle: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.black,
    //                 fontSize: 20),
    //             backgroundColor: Colors.greenAccent,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.all(Radius.circular(20))),
    //             content: Text("Save successfully"),
    //           );
    //         },
    //       );
    //       setState(() {
    //         isLoading = false;
    //       });
    //       _cleardata();
    //       print('Response body: $responseBody');
    //     } else {
    //       setState(() {
    //         isLoading = false;
    //       });
    //       showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             title: Text("Gagal"),
    //             titleTextStyle: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.black,
    //                 fontSize: 20),
    //             backgroundColor: Colors.greenAccent,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.all(Radius.circular(20))),
    //             content: Text("${responseBody}"),
    //           );
    //         },
    //       );
    //       print(
    //           'Failed to upload data and file. Status code: ${response.statusCode}');
    //     }
    //   } catch (e) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     print('Error uploading data and file: $e');
    //   }
    // }
  }

  // static Future<http.Response> updateSuratkeluar(
  //   String _kodeController,
  //   String _noAgendaController,
  //   String _noSuratController,
  //   String _tujuanController,
  //   String _isiController,
  //   String _tglSuratController,
  //   String _keteranganController,
  //   String _id_jenis_surat,
  //   String token,
  //   List<File> _selectedFiles,
  // ) async {
  //   var sendata = {
  //     'kode': _kodeController,
  //     'no_agenda': _noAgendaController,
  //     'no_surat': _noSuratController,
  //     'tujuan': _tujuanController,
  //     'isi_surat': _isiController,
  //     'tlg_surat': _tglSuratController,
  //     'keterangan': _keteranganController,
  //     'id_jenis_surat': _id_jenis_surat,
  //   };

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'http://192.168.88.51/backend_arsip/public/api/v1/surat_keluar/insert'),
  //   );

  //   request.headers["Authorization"] = 'Bearer $token';

  //   request.fields.addAll(sendata);

  //   _selectedFiles.forEach((file) {
  //     var multipartFile = http.MultipartFile.fromBytes(
  //       'file',
  //       file.readAsBytesSync(),
  //       filename: file.path.split('/').last,
  //     );
  //     request.files.add(multipartFile);
  //   });

  //   try {
  //     var response = await request.send();
  //     return await http.Response.fromStream(response);
  //   } catch (e) {
  //     print('Error uploading data and file: $e');
  //     return http.Response('Error uploading data and file: $e', 500);
  //   }
  // }
}

// action to create or delete function in
// static Future<void> saveDataSurat() async{
//   String url = '${Base_Url}/surat_masuk/save';
//   var response = await http.post()
// }
