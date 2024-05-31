import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/components/splashScreen.dart';
import 'package:sistem_kearsipan/main.dart';
import 'package:sistem_kearsipan/screen/dataArsip.dart';
import 'package:sistem_kearsipan/screen/dataPegawai.dart';
import 'package:sistem_kearsipan/screen/pengajuan/pengajuan.dart';
import 'package:sistem_kearsipan/screen/satuan/satuan.dart';
import 'package:sistem_kearsipan/screen/sppdData.dart';
import 'package:sistem_kearsipan/screen/suratDisposisi.dart';
import 'package:sistem_kearsipan/screen/suratKeluar.dart';
import 'package:sistem_kearsipan/screen/suratMasuk.dart';

class RouteAplikasi {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/welcomepage':
        return _buildRoute(SplashScreen());
      case '/login':
        return MaterialPageRoute(
          builder: (_) => MyHomePage(
            title: "Silahkan Login",
          ),
        );
      case '/sppd':
        return _buildRoute(sppdData());
      case '/surat_masuk':
        return _buildRoute(suratMasuk());
      case '/surat_keluar':
        return _buildRoute(suratKeluar());
      case '/disposisi':
        return _buildRoute(suratDisposisi());
      case '/data_pegawai':
        return _buildRoute(dataPegawai());
      case '/arsip':
        return _buildRoute(dataArsip());
      case '/satuan':
        return _buildRoute(Satuan());
      case '/pengajuan':
        return _buildRoute(Pengajuan());
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

  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.9, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
