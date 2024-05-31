import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/arsipRepo.dart';
import 'package:sistem_kearsipan/route/transitionPage.dart';
import 'package:sistem_kearsipan/screen/Arsip/ArsipForm.dart';
import 'package:sistem_kearsipan/screen/satuan/satuanForm.dart';
import 'package:sistem_kearsipan/utils/reques.dart';
import 'package:sistem_kearsipan/widget/Button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Satuan extends StatefulWidget {
  const Satuan({super.key});

  @override
  State<Satuan> createState() => _SatuanState();
}

class _SatuanState extends State<Satuan> {
  final TextEditingController searchingdata = TextEditingController();

  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool isLoadingMore = false;
  int page = 0;
  bool isFocused = false;
  double heigOfSlide = 0.80;
  bool loading = true;
  bool deleteConfirm = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollistener);
    _focusNode.addListener(_onFocusChange);
    fetchData();
  }

  void _onFocusChange() {
    setState(() {
      heigOfSlide = 0.80;
      isFocused = _focusNode.hasFocus;
    });
  }

  Future<void> _deleteData(int? id) async {
    if (id == null) {
      print("Invalid ID: null");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Invalid ID'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final String passing = id.toString();
    print("delete $passing");

    try {
      var response = await deleteData('arsip/destroy/$passing');
      print("resdata: $response");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil di $response'),
          backgroundColor: Color.fromARGB(255, 3, 149, 112),
        ),
      );
      fetchData();
    } catch (e) {
      print('$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          backgroundColor: Colors.orange,
        ),
      );
    }
    Navigator.pop(context);
  }

  Future<void> fetchData() async {
    try {
      var data = await arsipRepo.listPengajuan(page, searchingdata.text);
      setState(() {
        suratData = data;
        loading = false;
      });
      print(data);
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('Error fetching data: $e');
    }
  }

  void _showConfirmationBottomSheet(BuildContext context, int id) {
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                    'Konfirmasi hapus',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.40,
                    child: GestureDetector(
                      onTap: () async {
                        await _deleteData(id);
                      },
                      child: Button(
                        title: "Hapus",
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
                        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            loading = true;
            page = 10;
            searchingdata.text = "";
          });
          fetchData();
        },
        backgroundColor: Color.fromARGB(255, 9, 125, 233),
        child: ClipOval(
          child: Container(
            color: Color.fromARGB(255, 9, 125, 233),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  loading = true;
                });
                fetchData();
              }, // Dapat diubah jika diperlukan, tetapi tidak akan dijalankan karena FloatingActionButton sudah memiliki onPressed
            ),
          ),
        ),
      ),
      appBar: AppBar(
        shadowColor: null,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        backgroundColor: Color.fromARGB(255, 9, 125, 233),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  transitionPage(SatuanForm(id: 0)),
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
          'Satuan Data',
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
                child: suratData.length == 0 && loading != true
                    ? Column(
                        children: [
                          Container(
                            child: Image.network(
                              "https://img.freepik.com/premium-vector/file-found-illustration-with-confused-people-holding-big-magnifier-search-no-result_258153-336.jpg",
                              height: MediaQuery.sizeOf(context).height * 0.40,
                              width: MediaQuery.sizeOf(context).width,
                            ),
                          ),
                          Text(
                            'Data Satuan Arsip Masih Kosong',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                                                      color: Colors.white,
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
                                                            transitionPage(
                                                              ArsipForm(
                                                                idarsip: suratData[
                                                                        index][
                                                                    'id_arsip'],
                                                                judul: suratData[
                                                                        index][
                                                                    'nama_arsip'],
                                                              ),
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
                                                          // setState(() {
                                                          //   deleteConfirm =
                                                          //       true;
                                                          // });
                                                          _showConfirmationBottomSheet(
                                                              context,
                                                              suratData[index]
                                                                  ['id_arsip']);
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
                Color.fromARGB(255, 9, 125, 233),
                Color.fromARGB(255, 12, 113, 221).withOpacity(
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
              ),
              // Confrim(context, deleteConfirm),
            ],
          ),
        ),
      ),
    );
  }

  Widget Confrim(BuildContext context, bool deleteConfirm) {
    return deleteConfirm
        ? SlidingUpPanel(
            backdropEnabled: true,
            panel: Center(
              child: Text("Konformasi"),
            ),
            body: Scaffold(
              appBar: AppBar(
                title: Text("Anda yakin hapus data ini"),
              ),
              body: Center(
                child: Text("This is the Widget behind the sliding panel"),
              ),
            ),
          )
        : Container();
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
                    searchingdata.text = value;
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

  @override
  void dispose() {
    super.dispose();
    // _focusNode;
    // isLoadingMore;
    // page;
    // isFocused;
    // heigOfSlide;
    // loading;
    // deleteConfirm;
  }
}
