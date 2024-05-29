import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectBox extends StatefulWidget {
  String tipeselctbox = "";
  String initvalues = "";
  String mappingvalue = "";

  SelectBox(
      {required tipeselectbox, required initvalues, required mappingvalue});

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  List fetchdata = [];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(14.0), // Border radius
      ),
      child: DropdownButtonFormField(
        value: null,
        items: fetchdata.map((items) {
          return DropdownMenuItem(
            child: Text(
              items.label.toString(),
            ),
            value: items.value.toString(),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.initvalues = value!;
          });
          // Handle your value change here
        },
        decoration: InputDecoration(
          labelText: 'Jenis surat',
          border: InputBorder.none, // Hide the default border
          contentPadding: EdgeInsets.symmetric(
              horizontal: 10.0), // Padding inside the dropdown
        ),
      ),
    );
  }
}
