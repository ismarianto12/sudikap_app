import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_kearsipan/bloc/bloc/disposisi_bloc.dart';
import 'package:sistem_kearsipan/repository/suratRepo.dart';

class GetCurrenDisposisi extends StatefulWidget {
  const GetCurrenDisposisi({super.key});

  @override
  State<GetCurrenDisposisi> createState() => _GetCurrenDisposisiState();
}

class _GetCurrenDisposisiState extends State<GetCurrenDisposisi> {
  List<dynamic> data = [];
  bool loading = false;

  @override
  Future<dynamic> getDisposisData() async {
    final suratrepo = SuratRepo();
    try {
      var response = await suratrepo.getlistDisposisi();
      print("response Data");
      print(response);
      // setState(() => {data = response});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Username dan password Salah ${e}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    getDisposisData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.length > 0
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
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
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${data[index]['no_surat']}',
                                      style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${data[index]['asal_surat']}',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
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
              },
            )
          : Container(
              child: Text("No Data Available"),
            ),
    );
  }

  @override
  void _dispose() {
    super.dispose();
  }
}
