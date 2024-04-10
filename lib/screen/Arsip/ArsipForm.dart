import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/repository/arsipRepo.dart';

class ArsipForm extends StatefulWidget {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Kembali",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
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
                        decoration: InputDecoration(labelText: 'Jenis Arsip'),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'Pilih Jenis Arsip') {
                            return 'Pilih Jenis Arsip';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _namaArsipController,
                        decoration: InputDecoration(labelText: 'Nama Arsip'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Nama Arsip';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
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
                        decoration: InputDecoration(labelText: 'Lokasi'),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value == 'Lokasi Arsip') {
                            return 'Pilih Jenis Arsip';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _namaArsipController,
                        decoration: InputDecoration(labelText: 'Jumlah'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan Nama Arsip';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _namaArsipController,
                        decoration: InputDecoration(labelText: 'Keterangan'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan Nama Arsip';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
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
