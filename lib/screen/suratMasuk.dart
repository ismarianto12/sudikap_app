import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/screen/Sppd/sppdForm.dart';
import 'package:sistem_kearsipan/screen/SuratMasuk/DetailSurat.dart';
import 'package:sistem_kearsipan/screen/suratKeluar/DetailSurat.dart';
import 'package:sistem_kearsipan/screen/SuratMasuk/SuratMasukForm.dart';
import 'package:sistem_kearsipan/screen/dataArsip.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class suratMasuk extends StatefulWidget {
  const suratMasuk({super.key});

  @override
  State<suratMasuk> createState() => _suratMasukState();
}

class _suratMasukState extends State<suratMasuk> {
  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  int page = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollistener);
    fetchData(); // Call fetchData() on initState()
  }

  Future<void> fetchData() async {
    try {
      var data = await SuratRepo.getData(page);
      setState(() {
        loading = false;
        suratData = data;
      });
      print(data);
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('Error fetching data: $e');
      // Handle error accordingly
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Button,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.add,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          )
        ],
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
        title: Text('List Surat Masuk'),
        actionsIconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
      ),
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.orange,
      //     borderRadius: BorderRadius.all(Radius.circular(100)),
      //   ),
      //   child: CircleAvatar(
      //     backgroundColor: Colors.orange,
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: FloatingActionButton(
      //         mini: false,
      //         elevation: 0,
      //         backgroundColor: Colors.transparent,
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => SuratMasukForm(),
      //             ),
      //           );
      //         },
      //         child: Icon(
      //           size: 120,
      //           Icons.add,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // // appBar: AppBar(
      // //   title: Text("Data SPPD - Perjalanan dinas"),
      // // ),

      body: SlidingUpPanel(
        backdropEnabled: false,
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
                      width: MediaQuery.sizeOf(context).width * 0.88,
                      child: SearchingBar(context)),
                  SizedBox(
                    width: 10,
                  ),
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
                child: loading
                    ? LoadingPage(color: Colors.black12, itemCount: 10)
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: isLoadingMore
                            ? suratData.length + 1
                            : suratData.length,
                        shrinkWrap: true,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   crossAxisSpacing: 10.0,
                        //   mainAxisSpacing: 10.0,
                        // ),
                        itemBuilder: (BuildContext context, int index) {
                          if (index < suratData.length) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.1,
                                      blurRadius: 0.1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                255, 242, 242, 242),
                                            child: Text("${index + 1}"),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                      DetailSurat(
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
                                        padding:
                                            const EdgeInsets.only(left: 45),
                                        child: Text(
                                          '${suratData[index]['asal_surat']}',
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
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // SizedBox(
              //   height: 100,
              // ),
              Center(
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzIiJeo1M5L_7SbnhJBsXbqZTEyegQKLd2uT85eE-DhUz7FPk8temsqW3KhZOqBAkd20A&usqp=CAU"),
              ),
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
      });
      page = page + 1;
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
    height: MediaQuery.of(context).size.width * 0.09,
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
