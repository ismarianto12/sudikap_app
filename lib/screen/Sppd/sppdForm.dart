import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/screen/Sppd/Lainnya.dart';
import 'package:sistem_kearsipan/screen/Sppd/SppdForm_create.dart';
import 'package:sistem_kearsipan/screen/Sppd/Tebusan.dart';
import 'package:sistem_kearsipan/screen/dashboard.dart';
import 'package:sistem_kearsipan/screen/sppdData.dart';
import 'package:sistem_kearsipan/widget/Button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class sppDform extends StatefulWidget {
  const sppDform({super.key});
  @override
  State<sppDform> createState() => _sppDformState();
}

class _sppDformState extends State<sppDform> {
  int indextab = 0;
  List<Widget> listdata = [
    SppdForm_create(),
    Tebusan(),
    Lainnya(),
  ];

  @override
  void _showConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/10302/10302977.png",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Anda Yakin Membatalkan ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'Data yang yang di buat tidak dapat disimpan.',
                style: TextStyle(
                  fontSize: 14.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.40,
                    child: GestureDetector(
                      onTap: () {},
                      child: Button(
                        title: "Lanjut",
                        color: Color.fromARGB(255, 4, 110, 152),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.40,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ));
                      },
                      child: Button(
                        title: "Batal",
                        color: Color.fromARGB(255, 255, 128, 0),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle left button press
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Text('Left Button'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle right button press
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Text('Right Button'),
                  // ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("Tambah Data SPPD"),
      // ),
      body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.86,
        minHeight: MediaQuery.of(context).size.height * 0.50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        panel: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.2,
                height: MediaQuery.sizeOf(context).height * 0.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  color: Color.fromARGB(133, 5, 70, 119),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(child: listdata[indextab]),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TabData(indextab),
            ),
            Center(
              child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTKyMsoiNANqeFRFKfGcnmQNc4KaAvXbg-qkhXyeikubLgCwssC405-82Vz7fokvy3IOc&usqp=CAU"),
            ),
            Text("Form SPTPD - ")
          ],
        ),
      ),
    );
  }

  Widget TabData(indexdata) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              _showConfirmationBottomSheet(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                indextab = 0;
              });
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.28,
              height: MediaQuery.sizeOf(context).width * 0.10,
              decoration: BoxDecoration(
                border: Border.all(
                  color: indextab == 0
                      ? Color.fromARGB(255, 6, 141, 156)
                      : Colors.black, // Warna border
                ),
                color: indextab == 0
                    ? Color.fromARGB(255, 6, 141, 156)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  'SPPD',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: indextab == 0
                          ? Colors.white
                          : const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                indextab = 1;
              });
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.28,
              height: MediaQuery.sizeOf(context).width * 0.10,
              decoration: BoxDecoration(
                border: Border.all(
                  color: indextab == 1
                      ? Color.fromARGB(255, 6, 141, 156)
                      : Colors.black, // Warna border
                ),
                color: indextab == 1
                    ? Color.fromARGB(255, 6, 141, 156)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  'Tebusan',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: indextab == 1
                          ? Colors.white
                          : const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                indextab = 2;
              });
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.28,
              height: MediaQuery.sizeOf(context).width * 0.10,
              decoration: BoxDecoration(
                border: Border.all(
                  color: indextab == 2
                      ? Color.fromARGB(255, 6, 141, 156)
                      : Colors.black, // Warna border
                ),
                color: indextab == 2
                    ? Color.fromARGB(255, 6, 141, 156)
                    : Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  'Lainya',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: indextab == 2
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 7, 7, 7),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dispose() {}
}
