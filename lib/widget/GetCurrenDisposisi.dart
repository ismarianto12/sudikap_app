import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_kearsipan/bloc/bloc/disposisi_bloc.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';
import 'package:sistem_kearsipan/screen/Disposisi/DisposisiDetail.dart';

class GetCurrenDisposisi extends StatefulWidget {
  const GetCurrenDisposisi({super.key});

  @override
  State<GetCurrenDisposisi> createState() => _GetCurrenDisposisiState();
}

class _GetCurrenDisposisiState extends State<GetCurrenDisposisi> {
  List<dynamic> data = [];
  bool loading = true;

  @override
  Future<dynamic> getDisposisData() async {
    final suratrepo = SuratRepo();
    try {
      var response = await suratrepo.getlistDisposisi();
      print("response Data");
      print("${response} parameter");
      setState(
        () {
          data = response;
          loading = false;
        },
      );
    } catch (e) {
      setState(
        () {
          data = [];
          loading = false;
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Java lang execption: ${e}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    getDisposisData();
    print("${data.length} panjangdata");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      child: loading
          ? LoadingPage(color: Colors.white24, itemCount: 6)
          : data.length > 0
              ? ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    print('${data[index]['sifat']} panjang data');
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisposisDetail(
                              disposisidata: data[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
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
                                        Text(
                                          '${data[index]['sifat']}',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${data[index]['asal_surat']}',
                                      style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
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
                      ),
                    );
                  },
                )
              : Container(
                  child: Column(
                    children: [
                      Image.network(
                          "https://img.freepik.com/free-vector/404-error-with-landscape-concept-illustration_114360-7898.jpg?size=626&ext=jpg&ga=GA1.1.2082370165.1716768000&semt=ais_user")
                    ],
                  ),
                ),
    );
  }

  @override
  void _dispose() {
    super.dispose();
  }
}
