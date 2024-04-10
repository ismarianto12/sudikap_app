import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/screen/Sppd/sppdForm.dart';
import 'package:sistem_kearsipan/screen/suratKeluar/DetailSurat.dart';
import 'package:sistem_kearsipan/screen/SuratMasuk/SuratMasukForm.dart';
import 'package:sistem_kearsipan/screen/dataArsip.dart';
import 'package:sistem_kearsipan/screen/suratKeluar/SuratKeluarForm.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class suratKeluar extends StatefulWidget {
  const suratKeluar({super.key});

  @override
  State<suratKeluar> createState() => _suratKeluarState();
}

class _suratKeluarState extends State<suratKeluar> {
  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollistener);
    fetchData(); // Call fetchData() on initState()
  }

  Future<void> fetchData() async {
    try {
      var data = await SuratRepo.getDataSuratKeluar(page);
      setState(() {
        suratData = data;
      });
      // print(data);
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error accordingly
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Button,
      floatingActionButton: CircleAvatar(
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 97, 97, 97),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuratKeluarForm(
                  idSurat: 0,
                ),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text("Data SPPD - Perjalanan dinas"),
      // ),
      body: SlidingUpPanel(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
        minHeight: MediaQuery.sizeOf(context).height * 0.55,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        panel: Column(
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
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: MediaQuery.sizeOf(context).width * 0.90,
                      child: SearchingBar(context)),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20)5
                  //   width: MediaQuery.sizeOf(context).width * 0.80,
                  //   child: TextFormField(
                  //     // controller: username,
                  //     decoration: InputDecoration(
                  //       isDense: true,x
                  //       contentPadding: EdgeInsets.fromLTRB(
                  //           10, 6, 10, 0), // Atur ukuran teks kecil di sini
                  //       labelText: 'Search',
                  //       prefixIcon: Icon(Icons.search),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.all(
                  //             Radius.circular(4.0)), // Mengatur radius border
                  //         borderSide: BorderSide(
                  //           color: Colors.grey, // Warna border
                  //           width: 1.0, // Ketebalan border
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.grey,
                  //   child: Icon(
                  //     Icons.filter_alt_sharp,
                  //     size: 29,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount:
                      isLoadingMore ? suratData.length + 1 : suratData.length,
                  shrinkWrap: true,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   crossAxisSpacing: 10.0,
                  //   mainAxisSpacing: 10.0,
                  // ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < suratData.length) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          child: Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              '${suratData[index]['no_surat']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 15.0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailSuratKeluar(
                                                  suratData: suratData[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 45),
                                      child: Text(
                                        '${suratData[index]['tujuan']}',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(),  
                        ],
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.arrow_back_ios_new),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Data Surat Keluar",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   "Kembali",
                    //   style: TextStyle(fontSize: 15),
                    // )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 100,
              // ),
              Center(
                child: Image.network(
                    "https://i.pinimg.com/736x/e9/80/82/e98082ffb2d6b55c886b97be1f340bef.jpg"),
              ),
              Text("Form SPTPD - ")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scrollistener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
        page = page + 1;
      });
      await fetchData();
      print("Scrool call");
    } else {
      print("tidak ");
    }
  }
}

Widget SearchingBar(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 234, 234, 234).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
      color: Color.fromARGB(122, 146, 146, 146),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.04,
              child: TextFormField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
