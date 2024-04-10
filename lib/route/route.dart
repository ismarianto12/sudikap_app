import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/main.dart';
import 'package:sistem_kearsipan/screen/dataArsip.dart';
import 'package:sistem_kearsipan/screen/dataPegawai.dart';
import 'package:sistem_kearsipan/screen/sppdData.dart';
import 'package:sistem_kearsipan/screen/suratDisposisi.dart';
import 'package:sistem_kearsipan/screen/suratKeluar.dart';
import 'package:sistem_kearsipan/screen/suratMasuk.dart';

class RouteAplikasi {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => MyHomePage(
            title: "Silahkan Login",
          ),
        );
      case '/sppd':
        return MaterialPageRoute(builder: (_) => sppdData());
      case '/surat_masuk':
        return MaterialPageRoute(builder: (_) => suratMasuk());
      case '/surat_keluar':
        return MaterialPageRoute(builder: (_) => suratKeluar());
      case '/disposisi':
        return MaterialPageRoute(builder: (_) => suratDisposisi());
      case '/data_pegawai':
        return MaterialPageRoute(builder: (_) => dataPegawai());
      case '/arsip':
        return MaterialPageRoute(builder: (_) => dataArsip());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    child: Text(
                      'Page Under Maintence, Page Route : ${setting.name}',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                MaterialButton(
                  color: Colors.red, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      'Back To Home',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}
