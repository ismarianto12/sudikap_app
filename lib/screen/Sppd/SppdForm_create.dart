import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/model/jenissppd_model.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class SppdForm_create extends StatefulWidget {
  const SppdForm_create({super.key});

  @override
  State<SppdForm_create> createState() => _SppdForm_createState();
}

class _SppdForm_createState extends State<SppdForm_create> {
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
    // _controller = AnimationController(vsync: this);
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        "A. Data Surat",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w200,
                                ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
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
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)),
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
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          labelText: 'No. Surat',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                labelText: 'Tgl Berangkat',
                                prefixIcon: Icon(Icons.calendar_month),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                labelText: 'Tgl Kembali',
                                prefixIcon: Icon(Icons.calendar_month),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 14,
                          ),
                          labelText: 'Atasan',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          labelText: 'Bawahan',
                          prefixIcon: Icon(Icons.person_2_rounded),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                labelText: 'Lama Perjalanan',
                                // prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Text(" *) Dalam hitungan Hari")
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          labelText: 'Pengikut',
                          // prefixIcon: Icon(Icons.copy),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          labelText: 'Mata Anggaran',
                          prefixIcon: Icon(Icons.list),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          labelText: 'Mata Anggaran',
                          prefixIcon: Icon(Icons.document_scanner),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          labelText: 'Keterangan',
                          prefixIcon: Icon(Icons.document_scanner),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          labelText: 'Dasar Surat',
                          prefixIcon: Icon(Icons.document_scanner),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Button(title: "Save", color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
