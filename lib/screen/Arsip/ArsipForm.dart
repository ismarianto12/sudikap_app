import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/repository/arsipRepo.dart';

class ArsipForm extends StatefulWidget {
  int idarsip = 0;
  ArsipForm({required this.idarsip});
  @override
  _ArsipFormState createState() => _ArsipFormState();
}

class _ArsipFormState extends State<ArsipForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaArsipController = TextEditingController();
  TextEditingController _jumlahController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();
  TextEditingController id_satuanController = TextEditingController();
  TextEditingController id_jenisController = TextEditingController();
  TextEditingController id_pejabatController = TextEditingController();

  String _selectedJenisArsip = ''; // Inisialisasi _selectedJenisArsip
  String _selectedLokasi = '';
  String _selectedSatuan = '';
  List<String> _selectedPermissions = [];

  List<String> _jenisArsip = [
    'Pilih Jenis Arsip',
    'Arsip Barang dan Jasa',
    'Arsip Bendahara',
    'Arsip Surat Keluar',
    'Arsip Surat Masuk Internal',
    'Arsip Surat Masuk Eksternal',
    'Arsip Surat Keputusan Rektor',
    'SPPD',
    'asda',
    'Surat Jalan',
    'Bendahara Pengeluaran',
  ];

  List<String> _lokasiArsip = [
    'Pilih Data Lokasi Arsip',
    'Ruang Kakankemenag',
    'Ruang Arsip Kemenag Kota Madiun',
    'Ruang Arsip Pendidikan Madrasah',
    'Ruang Arsip Bendahara',
    'Ruang Arsip HAJI',
    'dgdgd',
    'sd',
    'Ruang Kasubbag Keuangan',
  ];

  List<String> _satuanArsip = [
    '-Pilih Satuan-',
    'Bendel',
    'Lembar',
    'Map',
    'Dus',
    'Pack',
    'Outner',
    'Box',
  ];

  @override
  void initState() {
    super.initState();
    _selectedJenisArsip =
        _jenisArsip.first; // Set initial value to the first item in the list
    _selectedLokasi = _jenisArsip.first;
  }

  Future<void> _submitdata() async {
    var response = await arsipRepo.createArchive(
      _namaArsipController.text,
      _jumlahController.text,
      _keteranganController.text,
      id_satuanController.text,
      id_jenisController.text,
      id_pejabatController.text,
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            backgroundColor: Colors.greenAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Text("Save successfully"),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("java.lang.error.exception :"),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Text("${response.body}"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: null,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        backgroundColor: Colors.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              height: MediaQuery.sizeOf(context).width * 0.08,
              width: MediaQuery.sizeOf(context).width * 0.3,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitdata();
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
        // iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        title: Text(
          'Arsip ${widget.idarsip != 0 ? "Edit" : "Tambah"}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
        ),
        // Menghilangkan border bawah
        shape: Border(bottom: BorderSide.none),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 244, 244, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                            ),
                            isDense: true,
                            value: _selectedJenisArsip,
                            items: _jenisArsip.map((jenis) {
                              return DropdownMenuItem(
                                value: jenis,
                                child: Text(jenis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedJenisArsip = value!;
                              });
                            },
                            // decoration: InputDecoration(labelText: 'Jenis Arsip'),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'Pilih Jenis Arsip') {
                                return 'Pilih Jenis Arsip';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextFormField(
                          controller: _namaArsipController,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              labelText: 'Nama Arsip'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Nama Arsip';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                            ),
                            isDense: true,
                            value: _selectedJenisArsip,
                            items: _jenisArsip.map((jenis) {
                              return DropdownMenuItem(
                                value: jenis,
                                child: Text(jenis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedJenisArsip = value!;
                              });
                            },
                            // decoration: InputDecoration(labelText: 'Lokasi'),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == 'Lokasi Arsip') {
                                return 'Pilih Jenis Arsip';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _namaArsipController,
                            decoration: InputDecoration(
                              labelText: 'Jumlah',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan Nama Arsip';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _namaArsipController,
                            decoration: InputDecoration(
                              labelText: 'Keterangan',
                              enabledBorder: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Masukkan Nama Arsip';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
