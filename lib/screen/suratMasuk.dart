import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/route/transitionPage.dart';
import 'package:sistem_kearsipan/screen/Sppd/sppdForm.dart';
import 'package:sistem_kearsipan/screen/SuratMasuk/DetailSurat.dart';
import 'package:sistem_kearsipan/screen/suratKeluar/DetailSurat.dart';
import 'package:sistem_kearsipan/screen/SuratMasuk/SuratMasukForm.dart';
import 'package:sistem_kearsipan/screen/dataArsip.dart';
import 'package:sistem_kearsipan/screen/suratKeluar/SuratKeluarForm.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class suratMasuk extends StatefulWidget {
  const suratMasuk({super.key});

  @override
  State<suratMasuk> createState() => _suratMasukState();
}

class _suratMasukState extends State<suratMasuk> {
  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  final TextEditingController searchingcontroller = TextEditingController();
  bool isPanelOpen = false;

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
      var data = await SuratRepo.getData(page, searchingcontroller.text);
      print("Response Http: $data");
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
      backgroundColor: Colors.white,
      // bottomNavigationBar: Button,
      appBar: AppBar(
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.15,
        // elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
        actionsIconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_sharp),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // isPanelOpen ? Container() : Text('List Surat Masuk'),
            Container(
                width: MediaQuery.sizeOf(context).width * 0.68,
                child: SearchingBar(context, searchingcontroller)),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    transitionPage(
                      SuratMasukForm(
                        idSurat: 0,
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
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
        // onPanelClosed: () {
        //   setState(() {
        //     isPanelOpen != isPanelOpen;
        //   });
        // },
        onPanelSlide: (double pos) {
          setState(() {
            isPanelOpen = pos != 0;
          });
        },
        backdropEnabled: false,
        maxHeight: MediaQuery.sizeOf(context).height * 0.80,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: suratData.length == 0 && loading != true
                    ? Container(
                        child: Image.network(
                          "https://img.freepik.com/premium-vector/file-found-illustration-with-confused-people-holding-big-magnifier-search-no-result_258153-336.jpg",
                          height: MediaQuery.sizeOf(context).height * 0.40,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      )
                    : loading
                        ? LoadingPage(
                            color: const Color.fromARGB(255, 186, 186, 186),
                            itemCount: 13)
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: isLoadingMore
                                ? suratData.length + 1
                                : suratData.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              // print("fpajang data : ${suratData[index].length}");
                              if (index < suratData.length) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(0.5),
                                          //     spreadRadius: 0,
                                          //     blurRadius: 10,
                                          //     offset: Offset(1, 0),
                                          //   ),
                                          // ],
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // CircleAvatar(
                                                  //   backgroundColor:
                                                  //       const Color.fromARGB(255, 0, 0, 0),
                                                  //   child: Text(
                                                  //     "${index + 1}",
                                                  //     style: TextStyle(
                                                  //       color: Colors.white,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            '${suratData[index]['asal_surat']}',
                                                            style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255, 0, 0, 0),
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: suratData[
                                                                            index]
                                                                        [
                                                                        'disposisi'] ==
                                                                    'y'
                                                                ? MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .blue)
                                                                : MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .green),
                                                          ),
                                                          onPressed: () => {
                                                            null,
                                                          },
                                                          child: Text(
                                                            "${suratData[index]['disposisi'] == 'y' ? "Disposisi" : "Tidak"}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child:
                                                        PopupMenuButton<String>(
                                                      color: Color.fromARGB(
                                                          255, 243, 243, 243),
                                                      elevation: 0,
                                                      // Define the menu items
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        return <PopupMenuEntry<
                                                            String>>[
                                                          PopupMenuItem<String>(
                                                            value: 'edit',
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                    Icons.edit),
                                                                Text('Edit'),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'delete',
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(Icons
                                                                    .delete),
                                                                Text('Edit'),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'detail',
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(Icons
                                                                    .details),
                                                                Text('Edit'),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'detail',
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(Icons
                                                                    .sign_language_sharp),
                                                                Text('Edit'),
                                                              ],
                                                            ),
                                                          ),
                                                        ];
                                                      },
                                                      // Define what happens when a menu item is selected
                                                      onSelected:
                                                          (String value) {
                                                        print(
                                                            'Selected: $value');
                                                        if (value == 'edit') {
                                                          Navigator.push(
                                                            context,
                                                            transitionPage(
                                                              SuratKeluarForm(
                                                                idSurat: suratData[
                                                                        index][
                                                                    "id_surat"],
                                                              ),
                                                            ),
                                                          );
                                                        } else if (value ==
                                                            'detail') {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //     builder: (_) {
                                                          //       return ArsipForm(
                                                          //         idarsip: 0,
                                                          //         judul: '',
                                                          //       );
                                                          //     },
                                                          //   ),
                                                          // );
                                                        } else if (value ==
                                                            'delete') {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //     builder: (_) {
                                                          //       return ArsipForm(
                                                          //           idarsip: 0,
                                                          //           judul: '');
                                                          //     },
                                                          //   ),
                                                          // );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${suratData[index]['tgl_surat']}',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${suratData[index]['keterangan']}',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0),
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                    ],
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
              Text(
                "Data Surat Masuk",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(context, Icons.airplane_ticket_outlined,
                        'Total Surat', 10),
                    _buildCard(context, Icons.input_sharp, 'Surat Masuk', 10),
                    _buildCard(context, Icons.input_sharp, 'Surat Masuk', 10),
                    _buildCard(context, Icons.mail, 'Surat Disposisi', 10),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
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

  Widget SearchingBar(
      BuildContext context, TextEditingController searchingcontroller) {
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
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 47,
                left: 10,
              ),
              child: Icon(Icons.search, color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.04,
                child: TextFormField(
                  controller: searchingcontroller,
                  onChanged: (String string) {
                    fetchData();
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: InputBorder.none,
                    labelText: 'Cari Surat',
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
}

Widget _buildCard(BuildContext context, icon, String title, int count) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.32,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 234, 234, 234).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 10), // changes position of shadow
          ),
        ]),
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 24,
            color: Colors.blue,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Jumlah: $count',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
