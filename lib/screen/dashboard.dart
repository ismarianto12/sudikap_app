import 'dart:ui';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/main.dart';
import 'package:sistem_kearsipan/screen/profile.dart';
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
    reportSurat(),
    reportSurat(),
    reportSurat(),
    reportSurat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(title: "Login Lagi"),
                  ),
                );
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
              minHeight: MediaQuery.sizeOf(context).height * 0.25,
              backdropEnabled: true,
              panel: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
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
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Surat Disposisi Terbaru",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  isPanelOpen
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
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
                          SingleChildScrollView(child: GetCurrenDisposisi()),
                          SizedBox(
                            height: 300,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: Scaffold(
                backgroundColor: null,
                body: Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    color: null,
                    image: DecorationImage(
                      alignment: Alignment(1.0, 0.8),
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        "https://img.freepik.com/premium-vector/person-holding-megaphone-concept-digital-marketing-flat-illustration_203633-7976.jpg",
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              size: 34,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "SUDIKAP APPS",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.notification_add_sharp,
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Sliderdashoard(),
                      SizedBox(
                        height: 4,
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
                          color: const Color.fromARGB(255, 161, 161, 161),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        icon: Icons.shopping_cart,
        text: 'Surat Masuk',
        color: Colors.green,
        route: "/surat_masuk"),
    MenuData(
        icon: Icons.notifications,
        text: 'Surat Keluar',
        color: Colors.orange,
        route: "/surat_keluar"),
    MenuData(
        icon: Icons.settings,
        text: 'Disposisi',
        color: Colors.cyan,
        route: "/disposisi"),
    MenuData(
        icon: Icons.favorite,
        text: 'Data Pegawai',
        color: Colors.orangeAccent,
        route: "/data_pegawai"),
    MenuData(
        icon: Icons.search,
        text: 'Arsip',
        color: Colors.yellow,
        route: "/arsip"),
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
          itemCount: 6,
        ),
      ),
    );
  }
}

Widget SearchingBar(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => searchDashoard(),
        ),
      );
    },
    child: Container(
      height: MediaQuery.of(context).size.width * 0.09,
      width: MediaQuery.sizeOf(context).width * 0.9,
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
