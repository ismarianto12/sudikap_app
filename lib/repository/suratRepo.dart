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

  static Future<dynamic> getData(int page, String search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String url = '${Base_Url}surat/list?page=$page&search=$search';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token!,
      },
    );
    try {
      if (response.statusCode == 200) {
        print(json.decode(response.body)['data']);
        return json.decode(response.body)['data'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("error : ${e.toString()}");
    }
  }

  // untuk surat masuk
  static Future<dynamic> getDataSuratKeluar(int page, String search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String url = '${Base_Url}surat_keluar/list?page=$page&search=${search!}';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<dynamic> getDataDisposisi(int page, String search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    String url = '${Base_Url}disposisi/list?page=$page';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("body response : ${token} ");
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

  Future<dynamic> getlistDisposisi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      var response = await http.get(
          Uri.parse("${Base_Url}disposisi/currentdisposisi"),
          headers: <String, String>{
            'Authorization': 'Bearer ${token}',
          });
      // print("${response.body} body res");
      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Failed to load data');
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
  static Future<dynamic> getCurrentsurat(String search) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    var response = await http
        .post(Uri.parse("${Base_Url}/currentletter"), headers: <String, String>{
      'Authorization': '${token}',
    }, body: {
      'search': search,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception("Cant get data");
    }
  }

  // report surat
  static Future<dynamic> ReportSurat(
      String asc, int perpage, String dari, String sampai) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    var response = await http.post(
      Uri.parse("${Base_Url}report/datareportsurat"),
      headers: <String, String>{"Authorization": "${token}"},
      body: {perpage: perpage, asc: asc, dari: dari, sampai: sampai},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data']['data'];
    } else {
      return response;
    }
  }

  // static Future<dynamic> apireportDisposisi(
  //     String asc, String perpage, String dari, String sampai) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? token = preferences.getString("token");
  //   var response = await http.post(
  //     Uri.parse("${Base_Url}report/reportdisposisi"),
  //     headers: <String, String>{"Authorization": "Bearer ${token}"},
  //     body: {'perpage': perpage, 'asc': asc, 'dari': dari, 'sampai': sampai},
  //   );
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body)["data"];
  //   } else {
  //     return response;
  //   }
  // }
  static Future<dynamic> apireportDisposisi(
      String asc, String perpage, String dari, String sampai) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      if (token == null) {
        throw Exception('Token not found');
      }
      String url = '${Base_Url}report/diposisi';
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
        body: {
          'perpage': perpage,
          'asc': asc,
          'dari': dari,
          'sampai': sampai,
        },
      );
      print(url);
      print("parsing");
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data']['data'];
        return responseData;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      // Rethrow the caught error to propagate it upwards
      throw e;
    }
  }
}
