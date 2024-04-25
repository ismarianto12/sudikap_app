import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/arsipRepo.dart';
import 'package:sistem_kearsipan/screen/Arsip/ArsipForm.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class dataArsip extends StatefulWidget {
  const dataArsip({super.key});

  @override
  State<dataArsip> createState() => _dataArsipState();
}

class _dataArsipState extends State<dataArsip> {
  final TextEditingController searchingdata = TextEditingController();

  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool isLoadingMore = false;
  int page = 0;
  bool isFocused = false;
  double heigOfSlide = 0.80;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollistener);
    _focusNode.addListener(_onFocusChange);
    fetchData();
  }

  void _onFocusChange() {
    setState(() {
      heigOfSlide = 0.30;
      isFocused = _focusNode.hasFocus;
    });
  }

  Future<void> fetchData() async {
    try {
      var data = await arsipRepo.listdataArsip(page, searchingdata.text);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: null,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        backgroundColor: Colors.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ArsipForm(idarsip: 0, judul: "");
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.add,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
        // iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        title: Text(
          'Master data Arsip',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
        ),
        // Menghilangkan border bawah
        shape: Border(bottom: BorderSide.none),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => ArsipForm(),
      //       ),
      //     );
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        margin: EdgeInsets.only(left: 28, right: 28),
        maxHeight: MediaQuery.sizeOf(context).height * 0.87,
        minHeight: MediaQuery.sizeOf(context).height * heigOfSlide,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        panel: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 16),
              child: SearchingBar(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: suratData.length == 0
                    ? Expanded(
                        child: Container(
                          child: Text("Tidak ada data"),
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
                                                    child: Text(
                                                      '${suratData[index]['nama_arsip']}',
                                                      style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0),
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child:
                                                        PopupMenuButton<String>(
                                                      // Define the menu items
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        return <PopupMenuEntry<
                                                            String>>[
                                                          PopupMenuItem<String>(
                                                            value: 'edit',
                                                            child: Text('Edit'),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'delete',
                                                            child:
                                                                Text('Delete'),
                                                          ),
                                                          PopupMenuItem<String>(
                                                            value: 'detail',
                                                            child:
                                                                Text('Detail'),
                                                          ),
                                                        ];
                                                      },
                                                      // Define what happens when a menu item is selected
                                                      onSelected:
                                                          (String value) {
                                                        // print('Selected: $value');
                                                        if (value == 'edit') {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) {
                                                                return ArsipForm(
                                                                  idarsip: suratData[
                                                                          index]
                                                                      [
                                                                      'id_arsip'],
                                                                  judul: suratData[
                                                                          index]
                                                                      [
                                                                      'nama_arsip'],
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        } else if (value ==
                                                            'detail') {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) {
                                                                return ArsipForm(
                                                                  idarsip: 0,
                                                                  judul: '',
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        } else if (value ==
                                                            'delete') {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) {
                                                                return ArsipForm(
                                                                    idarsip: 0,
                                                                    judul: '');
                                                              },
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${suratData[index]['tanggal']}',
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
                                                    '${suratData[index]['jenis_arsip']}',
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
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green,
                Colors.green.withOpacity(
                    0), // Opacity set to 0 to make it transparent at the bottom
              ],
              stops: [0.3, 0.3], // Stop at 50% of the height
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.linear_scale_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "List Data Arsip",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
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
                  print("${value} param");
                  fetchData();
                },
                controller: searchingdata,
                focusNode: _focusNode,
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
}
