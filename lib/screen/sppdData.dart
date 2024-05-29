import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Loadingpage.dart';
import 'package:sistem_kearsipan/repository/arsipRepo.dart';
import 'package:sistem_kearsipan/screen/Sppd/SppdForm_create.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class sppdData extends StatefulWidget {
  const sppdData({super.key});

  @override
  State<sppdData> createState() => _sppdDataState();
}

class _sppdDataState extends State<sppdData> {
  List<dynamic> suratData = [];
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool loading = true;
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollistener);
    fetchData(); // Call fetchData() on initState()
  }

  Future<void> fetchData() async {
    try {
      var data = await arsipRepo.getData(page);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        backgroundColor: Color.fromARGB(226, 0, 170, 255),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => SppdForm_create()));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SppdForm_create(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.add,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
        title: Text(
          'Master SPPD',
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
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        margin: EdgeInsets.only(left: 28, right: 28),
        maxHeight: MediaQuery.sizeOf(context).height * 0.80,
        minHeight: MediaQuery.sizeOf(context).height * 0.80,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        panel: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 16),
              child: SearchingBar(context),
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
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
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
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
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
        body: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 170, 255),
                Colors.green.withOpacity(
                    0), // Opacity set to 0 to make it transparent at the bottom
              ],
              stops: [0.3, 0.3], // Stop at 50% of the height
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //       child: Icon(
              //         Icons.arrow_back_ios_new,
              //         color: Colors.white,
              //       ),
              //     ),
              //     Text(
              //       "Master data SPPD",
              //       style: TextStyle(fontSize: 16, color: Colors.white),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     // Text(
              //     //   "Kembali",
              //     //   style: TextStyle(fontSize: 15),
              //     // )
              //   ],
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 40, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Surat Perintah Perjalanan Dinas",
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
