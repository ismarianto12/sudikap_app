import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marquee/marquee.dart';
import 'package:sistem_kearsipan/repository/marqueewidget.dart';

class AlertStatus extends StatelessWidget {
  final String title;
  const AlertStatus({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.10,
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color.fromARGB(133, 5, 70, 119),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Marquee(
              text: 'Selamat datang di aplikasi manajemen arsip dan surat .',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Marquee(
          //   key: key,
          //   title: this.title,
          //   style: TextStyle(
          //     color: Colors.white,
          //     leadingDistribution: TextLeadingDistribution.even,
          //     // wordSpacing: 10.0,
          //   ),
          // ),
          // MarqueeWidget(
          //   direction: Axis.horizontal,
          //   child: Text("This text is to long to be shown in just one line "),
          // ),

          Icon(
            Icons.close,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
