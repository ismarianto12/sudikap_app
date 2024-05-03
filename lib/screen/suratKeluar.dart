import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
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
  // TextEditingController searchingdata = TextEditingController();
  final scrollController = ScrollController();
  final TextEditingController searchcontroller = TextEditingController();
  bool isLoadingMore = false;
  int page = 1;
  int totaldata = 0;
  bool loading = true;
  String todata = '';

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollistener);
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await SuratRepo.getDataSuratKeluar(page, searchcontroller.text);
    // print(data[0]['data']);
    setState(() {
      suratData = data['data'];
      totaldata = data['total'];
      todata = data['to'];
      loading = false;
    });
    print("response Data s ${suratData}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('List Surat Keluar'),
        actionsIconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
      ),
      floatingActionButton: CircleAvatar(
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 97, 97, 97),
          onPressed: () {
            setState(() {
              searchcontroller.text = "";
              page = 10;
              loading = true;
            });

            fetchData();
          },
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text("Data SPPD - Perjalanan dinas"),
      // ),
      body: SlidingUpPanel(
        // backdropEnabled: true,
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
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: loading
                    ? LoadingPage(color: Colors.black26, itemCount: 8)
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    '${suratData[index]['no_surat']}',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0),
                                                      fontSize: 15.0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                        suratData:
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
        loading = false;
        isLoadingMore = true;
        if (todata.isEmpty) {
          page = page - 1;
        } else {
          page = page + 1;
        }
      });
      await fetchData();
      print("Scrool call");
    } else {
      print("tidak ");
    }
  }

  Widget SearchingBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.09,
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
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14, left: 10),
              child: Icon(Icons.search, color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.04,
                child: TextFormField(
                  onChanged: (String value) {
                    // print("${value} param");
                    fetchData();
                  },
                  controller: searchcontroller,
                  // focusNode: _focusNode,
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

  @override
  void dispose() {
    suratData;
    scrollController;
    searchcontroller;
    isLoadingMore;
    page;
    totaldata;
    loading;
    todata;
    super.dispose();
  }
}
