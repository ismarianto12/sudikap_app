import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Comloading extends StatelessWidget {
  final String title;

  Comloading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularProgressIndicator(
            color: Color.fromARGB(255, 9, 92, 128),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }
}
//example to implements
// void showLoading(loading) {
//     loading
//         ? showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (BuildContext context) {
//               return Dialog(child: Comloading(title: "Pleae Wait"));
//             },
//           )
//         : null;
  //}