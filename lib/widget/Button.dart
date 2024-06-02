import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color color;

  const Button({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainerWithTap(
      title: title,
      color: color,
    );
  }
}

class AnimatedContainerWithTap extends StatefulWidget {
  final String title;
  final Color color;

  const AnimatedContainerWithTap({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  _AnimatedContainerWithTapState createState() =>
      _AnimatedContainerWithTapState();
}

class _AnimatedContainerWithTapState extends State<AnimatedContainerWithTap> {
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    // Mulai animasi secara otomatis saat widget dirender
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isTapped = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        // widt
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * 0.06,
        child: TextButton(
          style: TextButton.styleFrom(
              // backgroundColor: Color.fromARGB(255, 0, 194, 253),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero)),
          child: Text(
            widget.title,
            // style:  ,
          ),
          onPressed: null,
        ),
      ),
    );
  }
}
