import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/model/jenissppd_model.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class Lainnya extends StatefulWidget {
  const Lainnya({super.key});

  @override
  State<Lainnya> createState() => _LainnyaState();
}

class _LainnyaState extends State<Lainnya> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String dropdownValue = '';

  List<Jenis_sppd> getJenissppd = <Jenis_sppd>[
    Jenis_sppd("", 'Pilih Jenis SPPD', ''),
    Jenis_sppd("1", 'SPPD Luar Kota', 'luarkota'),
    Jenis_sppd("2", 'SPPD Dalam Kota', 'dalamkota'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Text(
                  "C. Lainya",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<Jenis_sppd>(
                    value: dropdownValue != null
                        ? getJenissppd.firstWhere(
                            (element) => element.name == dropdownValue,
                            orElse: () => getJenissppd.first,
                          )
                        : null,
                    isExpanded: true,
                    underline: null,
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    onChanged: (Jenis_sppd? newValue) {
                      setState(() {
                        dropdownValue = newValue!.name;
                      });
                    },
                    items: getJenissppd.map<DropdownMenuItem<Jenis_sppd>>(
                      (Jenis_sppd value) {
                        return DropdownMenuItem<Jenis_sppd>(
                          value: value,
                          child: Text(value.name),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<Jenis_sppd>(
                    value: dropdownValue != null
                        ? getJenissppd.firstWhere(
                            (element) => element.name == dropdownValue,
                            orElse: () => getJenissppd.first,
                          )
                        : null,
                    isExpanded: true,
                    underline: null,
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    onChanged: (Jenis_sppd? newValue) {
                      setState(() {
                        dropdownValue = newValue!.name;
                      });
                    },
                    items: getJenissppd.map<DropdownMenuItem<Jenis_sppd>>(
                      (Jenis_sppd value) {
                        return DropdownMenuItem<Jenis_sppd>(
                          value: value,
                          child: Text(value.name),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<Jenis_sppd>(
                    value: dropdownValue != null
                        ? getJenissppd.firstWhere(
                            (element) => element.name == dropdownValue,
                            orElse: () => getJenissppd.first,
                          )
                        : null,
                    isExpanded: true,
                    underline: null,
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    onChanged: (Jenis_sppd? newValue) {
                      setState(() {
                        dropdownValue = newValue!.name;
                      });
                    },
                    items: getJenissppd.map<DropdownMenuItem<Jenis_sppd>>(
                      (Jenis_sppd value) {
                        return DropdownMenuItem<Jenis_sppd>(
                          value: value,
                          child: Text(value.name),
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   maxLines: 2,
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     contentPadding: EdgeInsets.symmetric(
                //       vertical: 10,
                //       horizontal: 10,
                //     ),
                //     labelText: 'Catatan',
                //     prefixIcon: Icon(Icons.note),
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 8, //or null
                        decoration:
                            InputDecoration.collapsed(hintText: "Catatan"),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Button(title: "Save", color: Colors.orange),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
