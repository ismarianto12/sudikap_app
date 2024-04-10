import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_kearsipan/environtment.dart';

class SppdRepo {
  //call data sppd
  static Future<dynamic> getData(
      String perpage, String total, String search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      var response = http.post(Uri.parse('${Base_Url}/sptpd/list'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Bearer': '${token}'
          });
      return response;
    } catch (e) {
      throw Exception("failed get data user ${e}");
    }
  }
}
