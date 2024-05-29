import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/widget/Button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class reportDisposisi extends StatefulWidget {
  String typereport = "surat";
  reportDisposisi({required typereport});

  @override
  State<reportDisposisi> createState() => _reportSuratState();
}

class _reportSuratState extends State<reportDisposisi> {
  TextEditingController _dariController = TextEditingController();
  TextEditingController _sampaiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List<dynamic> suratData = [];

  String asc = 'desc';
  String perpage = '1';
  double heightpanel = 0.50;
  bool isPanelOpen = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getReportData() async {
    try {
      var data = await SuratRepo.apireportDisposisi(
          asc, perpage, _dariController.text, _sampaiController.text);
      print("responsenya");
      print(data);
      setState(() {
        loading = false;
        suratData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Can\'t call api: ${e}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
          maxHeight:
              isPanelOpen ? MediaQuery.of(context).size.height * 0.90 : 0,
          minHeight: isPanelOpen
              ? MediaQuery.of(context).size.height * heightpanel
              : 0,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          panel: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          heightpanel = heightpanel == 0.90 ? 0.55 : 0.90;
                        });
                      },
                      child: heightpanel == 0.90
                          ? Text('Tampilkan Sedikit ...')
                          : Text('Tampilakan semua ...'),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isPanelOpen = false;
                          });
                        },
                        child: Icon(Icons.close)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: loading
                      ? LoadingPage(color: Colors.black26, itemCount: 14)
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
                                                    '${suratData[index]['no_surat']}',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
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
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${suratData[index]['asal_surat']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 14.0,
                                              ),
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Laporan Disposisi",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty || value == "") {
                              return "Silahkan pilih periode dari";
                            }
                          },
                          controller: _dariController,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((pickedDate) {
                              FocusScope.of(context).unfocus();
                              if (pickedDate != null) {
                                setState(() {
                                  _dariController.text =
                                      pickedDate.toString().split(' ')[0];
                                });
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'Dari',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  4.0)), // Mengatur radius border
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty || value == "") {
                              return "Silahkan pilih periode sampai dengan";
                            }
                          },
                          // controller: password,
                          controller: _sampaiController,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((pickedDate) {
                              FocusScope.of(context).unfocus();
                              if (pickedDate != null) {
                                setState(() {
                                  _sampaiController.text =
                                      pickedDate.toString().split(' ')[0];
                                });
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'Sampai',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                getReportData();
                                setState(() {
                                  isPanelOpen = true;
                                });
                              }
                            },
                            child: Button(
                                title: "Cari Data", color: Colors.orange)),
                        SizedBox(
                          height: 100,
                        ),
                        Image.network(
                          "https://cdni.iconscout.com/illustration/premium/thumb/search-engine-optimization-3678968-3092479.png?f=webp",
                          height: 200,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  // @override
  // void dispose() {
  //   _dariController.dispose();
  //   _sampaiController.dispose();
  //   super.dispose();
  // }
}
