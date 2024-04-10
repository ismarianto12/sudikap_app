import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/widget/Button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class reportSurat extends StatefulWidget {
  const reportSurat({super.key});

  @override
  State<reportSurat> createState() => _reportSuratState();
}

class _reportSuratState extends State<reportSurat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: MediaQuery.sizeOf(context).height * 0.55,
        minHeight: MediaQuery.sizeOf(context).height * 0.88,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        panel: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Silahkan filter data untuk mengurutkan "),
                  Icon(
                    Icons.filter_alt_sharp,
                    size: 29,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      TextFormField(
                        // controller: username,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10), // Atur ukuran teks kecil di sini
                          labelText: 'Dari',
                          // prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(4.0)), // Mengatur radius border
                            borderSide: BorderSide(
                              color: Colors.grey, // Warna border
                              width: 1.0, // Ketebalan border
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        // controller: password,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10), // Atur ukuran teks kecil di sini
                          labelText: 'Sampai',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Button(title: "Cari Data", color: Colors.orange)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.network(
                "https://cdn-icons-png.freepik.com/512/8899/8899649.png",
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
