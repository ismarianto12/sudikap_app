import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    print('${_currentPage} current');
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController?.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Sudikap (surat dinas dan kearsipan) APPS",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  ),
                  _assigmenText(_currentPage),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.6 * 0.1),
                child: Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        Image.network(
                          "https://static.vecteezy.com/system/resources/thumbnails/013/927/147/small_2x/adaptive-interface-design-illustration-concept-on-white-background-vector.jpg",
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          "https://cdni.iconscout.com/illustration/premium/thumb/login-10299071-8333958.png?f=webp",
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          "https://img.freepik.com/free-vector/colleagues-working-together-project_74855-6308.jpg",
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: _currentPage == index ? 100 : 30,
                            height: 14,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Color.fromARGB(255, 6, 145, 134)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _assigmen(_currentPage),
          ],
        ),
      ),
    );
  }

  Widget _assigmenText(currentIndex) {
    if (currentIndex == 0) {
      return Text(
        "Selamat datang di layanan sekali klik arsip",
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w100),
      );
    } else if (currentIndex == 1) {
      return Text(
        "Mempermudah pengelolaan arsip",
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w100),
      );
    } else if (currentIndex == 2) {
      return Text(
        "Mempermudah pengelolaan data surat",
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w100),
      );
    } else {
      return Text(
        "Selamat datang di layanan sekali klik arsip",
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      );
    }
  }

  Widget _assigmen(currentIndex) {
    if (currentIndex == 2) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Button(
            title: "Get Started",
            color: const Color.fromARGB(255, 243, 166, 33)),
      );
    } else {
      return Container();
    }
  }
}
