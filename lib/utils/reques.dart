import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_kearsipan/environtment.dart';

final _base = Base_Url;
final _loginEndPoint = "/public/api/login";
final Uri _tokenURL = Uri.http(_base, _loginEndPoint);

Future<dynamic> getToken(String userLogin) async {
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin),
  );
  if (response.statusCode == 200) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonResponse = json.decode(response.body);
    // String token = Token.fromJson(jsonResponse);
    prefs.setString("token", jsonResponse.token);
    prefs.setString("name", jsonResponse.name);
    return jsonResponse;
  } else {
    print("error" + response.body);
    throw Exception(json.decode(response.body));
  }
}

Future<dynamic> postData(var jsonRequest, String path) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  Uri endPoint = Uri.http(_base, path);
  final http.Response response = await http.post(
    endPoint,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token!,
      'Accept': 'Application/json'
    },
    body: jsonRequest,
  );
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<dynamic> putData(var jsonRequest, String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  Uri endPoint = Uri.http(_base, path);
  final http.Response response = await http.put(
    endPoint,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token!,
      'Accept': 'Application/json'
    },
    body: jsonRequest,
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<dynamic> deleteData(String path) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  Uri endPoint = Uri.http(_base, path);
  print("response server");
  print(endPoint);

  final http.Response response = await http.delete(
    endPoint,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token!,
      'Accept': 'Application/json'
    },
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<dynamic> postFormdata(
    String filePath, var params, String endpointpath) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ' + token!
  };

  Uri endPoint = Uri.http(_base, endpointpath);
  var request = http.MultipartRequest('POST', endPoint);
  request.headers.addAll(headers);
  request.files.add(await http.MultipartFile.fromPath("imageFile", filePath));

  params.forEach((k, element) {
    String param = json.encode(element);
    if (k == 'document') {
      param = json.encode(element);
      //  param = jsonDecode(param);
    }
    request.fields[k] = param;
  });

  final response = await request.send();
  final respStr = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    return respStr;
  } else {
    throw Exception(json.decode(respStr));
  }
}

Future<dynamic> uploadImage(File image, String endpointpath) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ' + token!,
    'Accept': 'Application/json'
  };

  Uri endPoint = Uri.http(_base, endpointpath);
  var request = http.MultipartRequest('POST', endPoint);
  request.headers.addAll(headers);
  request.files.add(http.MultipartFile.fromBytes(
      'image', await image.readAsBytes(),
      filename: "upload.jpg"));

  final response = await request.send();
  final respStr = await response.stream.bytesToString();
  //print(respStr);
  if (response.statusCode == 201) {
    return respStr;
  } else {
    throw Exception(json.decode(respStr));
  }
}

Future<dynamic> getData(String path, [String? search]) async {
  Uri endPoint = Uri.http(_base, path, {"search": search});
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  final http.Response response =
      await http.get(endPoint, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ' + token!,
    'Accept': 'Application/json'
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(json.decode(response.body));
  }
}
