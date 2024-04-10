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
            // Gambar atau logo aplikasi Anda
            // Image.asset(
            //   'assets/images/logo.png', // Ganti dengan path logo atau gambar splash screen Anda
            //   width: 150, // Sesuaikan ukuran dengan kebutuhan
            // ),
            SizedBox(height: 20),
            // Teks atau nama aplikasi Anda
            Text(
              'Nama Aplikasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
