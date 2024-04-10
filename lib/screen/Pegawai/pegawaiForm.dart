import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pegawaiForm extends StatefulWidget {
  @override
  _pegawaiFormState createState() => _pegawaiFormState();
}

class _pegawaiFormState extends State<pegawaiForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController pendidikanController = TextEditingController();
  TextEditingController tahunLulusController = TextEditingController();
  TextEditingController tahunIjazahController = TextEditingController();
  TextEditingController pangkatController = TextEditingController();
  TextEditingController golonganController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController bidangController = TextEditingController();
  TextEditingController tanggalSerahTerimaController = TextEditingController();
  TextEditingController tahunMasukKerjaController = TextEditingController();
  TextEditingController catatanMutasiController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController namaPelatihanController = TextEditingController();
  TextEditingController tanggalPelatihanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black), // Mengatur warna tombol back menjadi hitam
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Colors.black), // Menggunakan ikon kembali dari iOS
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Data Pegawai',
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Umum',
              ),
              Tab(text: 'Pendidikan'),
              Tab(text: 'Jabatan'),
              Tab(text: 'Pelatihan'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: TabBarView(
                  children: [
                    // Umum
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Nip'),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Nama'),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'No Hp'),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Alamat'),
                              maxLines: null,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Tanggal Lahir'),
                              keyboardType: TextInputType.datetime,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Tempat Lahir'),
                              maxLines: null,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Pendidikan
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Pendidikan'),
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Tahun Lulus'),
                              keyboardType: TextInputType.datetime,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Tahun Ijazah'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Jabatan
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Pangkat'),
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Golongan'),
                            ),
                            DropdownButtonFormField(
                              items: [
                                DropdownMenuItem(
                                  child: Text('Juru Muda'),
                                  value: 'Juru Muda',
                                ),
                                DropdownMenuItem(
                                  child: Text('Juru Muda Tk. I'),
                                  value: 'Juru Muda Tk. I',
                                ),
                                // Add other items here
                              ],
                              onChanged: (value) {},
                              decoration: InputDecoration(labelText: 'Jabatan'),
                            ),
                            DropdownButtonFormField(
                              items: [
                                DropdownMenuItem(
                                  child:
                                      Text('DINAS PENDIDIKAN DAN KEBUDAYAAN'),
                                  value: 'DINAS PENDIDIKAN DAN KEBUDAYAAN',
                                ),
                                DropdownMenuItem(
                                  child: Text('DINAS KESEHATAN'),
                                  value: 'DINAS KESEHATAN',
                                ),
                                // Add other items here
                              ],
                              onChanged: (value) {},
                              decoration: InputDecoration(labelText: 'Bidang'),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Tanggal Serah Terima Jabatan'),
                              keyboardType: TextInputType.datetime,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Tahun Masuk Kerja'),
                              keyboardType: TextInputType.datetime,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Catatan Mutasi'),
                              maxLines: null,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Keterangan'),
                              maxLines: null,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Pelatihan
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Nama Pelatihan'),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Tanggal'),
                              keyboardType: TextInputType.datetime,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process your form data here
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        // Handle Cancel action here
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
