import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Tunggu 2 detik kemudian navigasikan ke halaman utama
    Timer(Duration(seconds: 2), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()), // Ganti dengan halaman utama aplikasi Anda
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ubah warna sesuai kebutuhan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "https://simpel4.ombudsman.go.id/media/svg/icons/Tools/banerlogin.png",
              width: 300,
            ),
            SizedBox(height: 20),
            // Teks atau nama aplikasi Anda
            Text(
              'Selamat datang di satu klik layanan arsip',
              style: TextStyle(
                fontSize: 19,
                color: Colors.black, // Ubah warna sesuai kebutuhan
              ),
            ),
            SizedBox(height: 20),
            // Loading indicator atau pesan lainnya
            CircularProgressIndicator(), // Ubah sesuai kebutuhan
            SizedBox(height: 30),

            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Button(title: "Get Started ..", color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}
