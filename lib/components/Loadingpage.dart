import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatelessWidget {
  final Color color;
  final int itemCount;

  const LoadingPage({Key? key, required this.color, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: this.color,
      highlightColor: this.color,
      child: ListView.builder(
        itemCount: this.itemCount, // Ganti jumlah item dengan yang diinginkan
        itemBuilder: (_, __) => ListTile(
          leading: CircleAvatar(),
          title: Container(
            height: 12,
            color: Colors.white,
          ),
          subtitle: Container(
            height: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
