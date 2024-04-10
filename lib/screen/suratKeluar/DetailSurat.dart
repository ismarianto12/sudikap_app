import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class DetailSuratKeluar extends StatelessWidget {
  final dynamic suratData;
  const DetailSuratKeluar({Key? key, this.suratData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "${suratData['asal_surat']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Detail Surat Keluar:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Table(
                      border: TableBorder.all(color: Colors.transparent),
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Nomor:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${suratData['no_surat']}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Indexs:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${suratData['indeks']}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Nomor Agenda:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${suratData['no_agenda']}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Tambahkan TableRow untuk data lainnya
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Isi Surat:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${suratData['isi']}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Kode:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${suratData['kode']}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "keterangan:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${suratData['keterangan']}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {},
              child: Button(title: "Download File", color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
