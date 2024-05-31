import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/screen/Disposisi/DisposisiDetail.dart';
import 'package:sistem_kearsipan/screen/Sppd/sppdForm.dart';
import 'package:sistem_kearsipan/screen/suratKeluar/DetailSurat.dart';
import 'package:sistem_kearsipan/screen/SuratMasuk/SuratMasukForm.dart';
import 'package:sistem_kearsipan/screen/dataArsip.dart';
import 'package:sistem_kearsipan/utils/reques.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class suratDisposisi extends StatefulWidget {
  const suratDisposisi({super.key});

  @override
  State<suratDisposisi> createState() => _suratDisposisiState();
}

class _suratDisposisiState extends State<suratDisposisi> {
  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  String search = '';
  int page = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollistener);
    getDataDisposisi(); // Call getDataDisposisi() on initState()
  }

  Future<dynamic> _deleteact(int id) async {
    try {
      var resonse = postData({'id': id}, "suratmasuk/destory/${id}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil di hapus'),
          backgroundColor: Colors.red,
        ),
      );
      getDataDisposisi();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> getDataDisposisi() async {
    print("disposisi data");
    try {
      var data = await SuratRepo.getDataDisposisi(page, search);

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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            loading = true;
            page = 10;
            // searchingdata.text = "";
          });
          // fetchData();
        },
        backgroundColor: Colors.green,
        child: ClipOval(
          child: Container(
            color: Colors.green,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  loading = true;
                });
                // fetchData();
              }, // Dapat diubah jika diperlukan, tetapi tidak akan dijalankan karena FloatingActionButton sudah memiliki onPressed
            ),
          ),
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Color.fromARGB(225, 255, 255, 255),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => sppDform(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
        title: Text(
          'List Disposisi',
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
      body: SlidingUpPanel(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
        minHeight: MediaQuery.sizeOf(context).height * 0.80,
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
            Row(
              // crossAxisAlignment: CrossAxisAlignment,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                    width: MediaQuery.sizeOf(context).width * 0.90,
                    child: SearchingBar(context)),

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
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: loading
                    ? LoadingPage(color: Colors.black45, itemCount: 10)
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: isLoadingMore
                            ? suratData.length + 1
                            : suratData.length,
                        shrinkWrap: true,
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
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 0, 0),
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
                                          InkWell(
                                            onTap: () {
                                              print("tekan tombol");
                                              //     Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(builder: (context) => DashboardScreen()),
                                              // );
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisposisDetail(
                                                    disposisidata:
                                                        suratData[index],
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
      });
      page = page + 1;
      await getDataDisposisi();
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
