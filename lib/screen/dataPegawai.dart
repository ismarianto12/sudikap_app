import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pager/pager.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/pegawaiRepo.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/screen/Pegawai/pegawaiForm.dart';
import 'package:sistem_kearsipan/screen/Sppd/sppdForm.dart';
import 'package:sistem_kearsipan/screen/suratKeluar/DetailSurat.dart';
import 'package:sistem_kearsipan/screen/SuratMasuk/SuratMasukForm.dart';
import 'package:sistem_kearsipan/screen/dataArsip.dart';
import 'package:sistem_kearsipan/utils/reques.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class dataPegawai extends StatefulWidget {
  @override
  State<dataPegawai> createState() => _dataPegawaiState();
}

class _dataPegawaiState extends State<dataPegawai> {
  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  int page = 0;
  bool loading = true;
  int totalpeg = 0;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(_scrollistener);
    fetchData(); // Call fetchData() on initState()
  }

  Future<void> fetchData() async {
    try {
      var data = await PegawaiRepo.getData(page);
      setState(() {
        loading = false;
        suratData = data;
        totalpeg = data?.length;
      });
      print(data);
    } catch (e) {
      setState(
        () {
          loading = false;
          suratData = [];
        },
      );
      print('Error fetching data: $e');
      // Handle error accordingly
    }
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
      fetchData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Button,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Color.fromARGB(255, 18, 92, 204),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pegawaiForm(id: 0, action: 'create'),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      // appBar: AppBar(
      //   title: Text("Data SPPD - Perjalanan dinas"),
      // ),
      body: SlidingUpPanel(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
        minHeight: MediaQuery.sizeOf(context).height * 0.67,
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
                color: Color.fromARGB(255, 18, 92, 204),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: SearchingBar(context)),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Pager(
              currentPage: _currentPage,
              totalPages: 5,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: loading
                    ? LoadingPage(color: Colors.black26, itemCount: 14)
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
                                  // border: Border.fromBorderSide(BorderSide.lerp(1,10)), // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 0.1,
                                  //     blurRadius: 0.1,
                                  //     offset: Offset(0, 2),
                                  //   ),
                                  // ],
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black, // Border color
                                      width: 0.1, // Border width
                                    ),
                                  ),
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
                                                255, 18, 92, 204),
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                '${suratData[index]['nama']}',
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
                                            onTap: () {},
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
                                          '${suratData[index]['nip']}',
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios_new),
                      Text(
                        "Data Pegawai",
                        style: TextStyle(fontSize: 20),
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCard(context, Icons.people, 'Total Pegawai', 10),
                      _buildCard(context, Icons.mail, 'Strata Satu', 10),
                      _buildCard(context, Icons.input_sharp, 'Strata Dua', 10),
                      _buildCard(context, Icons.mail, 'Strata Tiga', 10),
                    ],
                  ),
                ),
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
      setState(
        () {
          isLoadingMore = true;
          page = page + 1;
        },
      );

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
