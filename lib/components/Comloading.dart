import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Comloading extends StatelessWidget {
  final String title;

  Comloading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 140, 139, 139),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Color.fromARGB(255, 247, 247, 247),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${title} ...",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ],
          ),
        ),
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