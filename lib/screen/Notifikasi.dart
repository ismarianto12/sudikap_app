import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        backgroundColor: Color.fromARGB(225, 255, 255, 255),
        actions: <Widget>[],
        title: Text(
          'Notifikasi Surat',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
        // Menghilangkan border bawah
        shape: Border(bottom: BorderSide.none),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: loading
            ? LoadingPage(
                color: const Color.fromARGB(255, 182, 182, 182), itemCount: 10)
            : ContainerListData(context),
      ),
    );
  }

  Widget ContainerListData(BuildContext context) {
    return Container();
  }
}
