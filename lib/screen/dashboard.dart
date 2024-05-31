import 'dart:ui';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_kearsipan/environtment.dart';
import 'package:sistem_kearsipan/main.dart';
import 'package:sistem_kearsipan/screen/Notifikasi.dart';
import 'package:sistem_kearsipan/screen/profile.dart';
import 'package:sistem_kearsipan/screen/reportDisposisi.dart';
import 'package:sistem_kearsipan/screen/reportSurat.dart';
import 'package:sistem_kearsipan/screen/searchDasboard.dart';
import 'package:sistem_kearsipan/widget/Alert.dart';
import 'package:sistem_kearsipan/widget/GetCurrenDisposisi.dart';
import 'package:sistem_kearsipan/widget/Sliderdashoard.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;
  bool isPanelOpen = false;

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(_scaffoldKey.currentContext!).pop();
  }

  List<Widget> screens = [
    DashboardScreen(),
    reportDisposisi(typereport: 'disposisi'),
    reportSurat(typereport: "surat"),
    Profile(),
  ];

  @override
  initState() {
    super.initState();
    print("API_URL");
    print(Base_Url);
  }

  Future<void> logout(BuildContext context) async {
    // Tampilkan dialog konfirmasi logout
    bool confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Tutup dialog tanpa logout
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Tutup dialog dan lanjutkan logout
              },
              child: Text('Keluar'),
            ),
          ],
        );
      },
    );

    // Jika pengguna mengonfirmasi logout, hapus token dan navigasikan ke halaman login
    if (confirmLogout == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      await prefs.clear();
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _index == 0
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {},
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
                      setState(() {});
                    },
                  ),
                ),
              ),
            )
          : null,
      extendBody: true,
      bottomNavigationBar: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: FloatingNavbar(
          width: MediaQuery.sizeOf(context).width * 0.95,
          padding: EdgeInsets.only(top: 4, bottom: 3),
          margin: EdgeInsets.only(top: 1, bottom: 0),
          backgroundColor: Color.fromARGB(255, 4, 136, 165),
          selectedBackgroundColor: Colors.indigo,
          unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: Colors.white,
          onTap: (int val) {
            setState(() {
              _index = val;
            });
          },
          currentIndex: _index,
          items: [
            FloatingNavbarItem(
              icon: Icons.home,
              title: 'Home',
            ),
            FloatingNavbarItem(
              icon: Icons.explore,
              title: 'History Disposisi',
            ),
            FloatingNavbarItem(
              icon: Icons.chat_bubble_outline,
              title: 'Report Surat Kluar',
            ),
            FloatingNavbarItem(
              icon: Icons.person,
              title: 'Profile',
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  Text(
                    'Ismarianto',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '- (User)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Ganti Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: _index == 0
          ? SlidingUpPanel(
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 0.1)],
              onPanelSlide: (double pos) {
                setState(() {
                  isPanelOpen = pos != 0;
                });
              },
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              maxHeight: MediaQuery.sizeOf(context).height * 0.80,
              minHeight: isPanelOpen
                  ? MediaQuery.sizeOf(context).height * 0.80
                  : MediaQuery.sizeOf(context).height * 0.22,
              backdropEnabled: true,
              panel: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  isPanelOpen
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            width: MediaQuery.sizeOf(context).width,
                            // padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Scrool ke atas untuk melihat disposisi terbaru",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(
                    height: isPanelOpen ? 10 : 200,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          Text(
                            "Surat Disposisi Terbaru",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          SingleChildScrollView(child: GetCurrenDisposisi()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: Scaffold(
                // backgroundColor: Color.fromARGB(194, 0, 195, 255),
                body: Container(
                  width: MediaQuery.sizeOf(context).width,
                  // height: MediaQuery.sizeOf(context).height * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        HSLColor.fromAHSL(1.0, 240, 1.0, 0.2)
                            .toColor(), // hsl(240deg 100% 20%)
                        HSLColor.fromAHSL(1.0, 227, 1.0, 0.23)
                            .toColor(), // hsl(227deg 100% 23%)
                        HSLColor.fromAHSL(1.0, 220, 1.0, 0.26)
                            .toColor(), // hsl(220deg 100% 26%)
                        HSLColor.fromAHSL(1.0, 215, 1.0, 0.28)
                            .toColor(), // hsl(215deg 100% 28%)
                        HSLColor.fromAHSL(1.0, 210, 1.0, 0.31)
                            .toColor(), // hsl(210deg 100% 31%)
                        HSLColor.fromAHSL(1.0, 205, 1.0, 0.32)
                            .toColor(), // hsl(205deg 100% 32%)
                        HSLColor.fromAHSL(1.0, 201, 1.0, 0.34)
                            .toColor(), // hsl(201deg 100% 34%)
                        HSLColor.fromAHSL(1.0, 201, 0.74, 0.41)
                            .toColor(), // hsl(201deg 74% 41%)
                        HSLColor.fromAHSL(1.0, 201, 0.51, 0.49)
                            .toColor(), // hsl(201deg 51% 49%)
                        HSLColor.fromAHSL(1.0, 199, 0.47, 0.56)
                            .toColor(), // hsl(199deg 47% 56%)
                        HSLColor.fromAHSL(1.0, 197, 0.44, 0.62)
                            .toColor(), // hsl(197deg 44% 62%)
                        HSLColor.fromAHSL(1.0, 195, 0.42, 0.69)
                            .toColor(), // hsl(195deg 42% 69%)
                        HSLColor.fromAHSL(1.0, 192, 0.39, 0.76)
                            .toColor(), // hsl(192deg 39% 76%)
                        HSLColor.fromAHSL(1.0, 189, 0.36, 0.83)
                            .toColor(), // hsl(189deg 36% 83%)
                        HSLColor.fromAHSL(1.0, 185, 0.31, 0.91)
                            .toColor(), // hsl(185deg 31% 91%)
                        HSLColor.fromAHSL(1.0, 180, 0.14, 0.99)
                            .toColor(), // hsl(180deg 14% 99%)
                      ],
                      stops: [
                        0.0,
                        0.07,
                        0.13,
                        0.2,
                        0.27,
                        0.33,
                        0.4,
                        0.47,
                        0.53,
                        0.6,
                        0.67,
                        0.73,
                        0.8,
                        0.87,
                        0.93,
                        1.0
                      ],
                    ),
                    // color: null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     _openDrawer();
                          //   },
                          //   child: Icon(
                          //     Icons.menu,
                          //     size: 34,
                          //     color: Color.fromARGB(255, 255, 255, 255),
                          //   ),
                          // ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "SUDIKAP APPS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(215, 17, 73, 119),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Notifikasi();
                                    },
                                  ),
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  logout(context);
                                },
                                child: Icon(
                                  Icons.logout,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SearchingBar(context),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 25, top: 10),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         "Hy Rian",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .titleSmall!
                      //             .copyWith(
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //       ),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text(
                      //         ",Selamat Pagi",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .titleSmall!
                      //             .copyWith(
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 20, right: 20, top: 10),
                      //   child: AlertStatus(
                      //       title:
                      //           'Silahkan gunakan menu disamping untuk app...'),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Selamat Datang Di Pesisir Selatan",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Sliderdashoard(),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                            color: Colors.white,
                            image: DecorationImage(
                              alignment: Alignment(1.18, 0),
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                "https://img.freepik.com/premium-vector/person-holding-megaphone-concept-digital-marketing-flat-illustration_203633-7976.jpg",
                              ),
                            ),
                          ),
                          width: MediaQuery.sizeOf(context).width * 30,
                          height: MediaQuery.sizeOf(context).height,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Text(
                                  "Menu Apps",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                height: 0.1,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 161, 161, 161),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Menu(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : screens[_index],
    );
  }
}

class MenuData {
  final IconData icon;
  final String text;
  final Color color;
  final String route;
  MenuData(
      {required this.icon,
      required this.text,
      required this.color,
      required this.route});
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final String route;

  const MenuItem(
      {Key? key,
      required this.icon,
      required this.text,
      required this.color,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '${route}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 23,
            backgroundColor: color,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 28,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}

// class ListTile
Widget ListData(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 234, 234, 234).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 10), // changes position of shadow
          ),
        ],
        color: Color.fromARGB(255, 255, 143, 5),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Example Surat Yang Disampaikan...",
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  // width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 145, 145, 145).withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: Color.fromARGB(255, 255, 166, 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Segera",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "2023-January-01",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}

class Menu extends StatelessWidget {
  // const Menu({super.key});

  final List<MenuData> menuDataList = [
    MenuData(
        icon: Icons.account_circle,
        text: 'SPPD',
        color: Colors.red,
        route: "/sppd"),
    MenuData(
        icon: Icons.email_rounded,
        text: 'Surat Masuk',
        color: Colors.green,
        route: "/surat_masuk"),
    MenuData(
        icon: Icons.ios_share_rounded,
        text: 'Surat Keluar',
        color: Colors.orange,
        route: "/surat_keluar"),
    MenuData(
        icon: Icons.mark_email_read_sharp,
        text: 'Disposisi',
        color: Colors.cyan,
        route: "/disposisi"),
    MenuData(
        icon: Icons.people_outlined,
        text: 'Data Pegawai',
        color: Colors.orangeAccent,
        route: "/data_pegawai"),
    MenuData(
        icon: Icons.account_tree_sharp,
        text: 'Arsip',
        color: Colors.yellow,
        route: "/arsip"),
    MenuData(
        icon: Icons.account_tree_sharp,
        text: 'Satuan',
        color: const Color.fromARGB(255, 59, 101, 255),
        route: "/satuan"),
    MenuData(
        icon: Icons.ad_units,
        text: 'Pengajuan',
        color: Color.fromARGB(255, 174, 105, 7),
        route: "/pengajuan"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: MenuItem(
                icon: menuDataList[index].icon,
                text: menuDataList[index].text,
                color: menuDataList[index].color,
                route: menuDataList[index].route,
              ),
            );
          },
          itemCount: 8,
        ),
      ),
    );
  }
}

Widget SearchingBar(BuildContext context) {
  final List<MenuData> lismenu = [
    MenuData(
        icon: Icons.account_circle,
        text: 'SPPD',
        color: Colors.red,
        route: "/sppd"),
    MenuData(
        icon: Icons.email_rounded,
        text: 'Surat Masuk',
        color: Colors.green,
        route: "/surat_masuk"),
    MenuData(
        icon: Icons.ios_share_rounded,
        text: 'Surat Keluar',
        color: Colors.orange,
        route: "/surat_keluar"),
    MenuData(
        icon: Icons.mark_email_read_sharp,
        text: 'Disposisi',
        color: Colors.cyan,
        route: "/disposisi"),
    MenuData(
        icon: Icons.people_outlined,
        text: 'Data Pegawai',
        color: Colors.orangeAccent,
        route: "/data_pegawai"),
    MenuData(
        icon: Icons.account_tree_sharp,
        text: 'Arsip',
        color: Colors.yellow,
        route: "/arsip"),
  ];
  return GestureDetector(
    onTap: () {
      showSearch(context: context, delegate: CustomSearchDelegate(lismenu));
    },
    child: Container(
      height: MediaQuery.of(context).size.width * 0.09,
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: const Color.fromARGB(255, 234, 234, 234).withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 2), // changes position of shadow
        //   ),
        // ],
        color: Color.fromARGB(122, 146, 146, 146),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(
              width: 10,
            ),
            Text(
              "Searching ....",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    ),
  );
}
