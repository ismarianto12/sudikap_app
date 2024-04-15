import 'dart:async';
import 'package:flutter/material.dart';

class Sliderdashoard extends StatefulWidget {
  const Sliderdashoard({Key? key}) : super(key: key);

  @override
  _SliderdashoardState createState() => _SliderdashoardState();
}

class _SliderdashoardState extends State<Sliderdashoard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
                  "https://images.tokopedia.net/img/cache/1208/NsjrJu/2024/4/5/ebcdf4a8-5b03-4620-8b18-14fb940401fe.jpg.webp?ect=4g",
                  fit: BoxFit.cover,
                ),
                Image.network(
                  "https://images.tokopedia.net/img/cache/1208/NsjrJu/2024/4/5/ebcdf4a8-5b03-4620-8b18-14fb940401fe.jpg.webp?ect=4g",
                  fit: BoxFit.cover,
                ),
                Image.network(
                  "https://images.tokopedia.net/img/cache/1208/NsjrJu/2024/4/5/ebcdf4a8-5b03-4620-8b18-14fb940401fe.jpg.webp?ect=4g",
                  fit: BoxFit.cover,
                ),
              ],
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
                    width: _currentPage == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
