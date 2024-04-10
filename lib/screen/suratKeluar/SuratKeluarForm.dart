import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_kearsipan/repository/suratRepo.dart';

class SuratKeluarForm extends StatefulWidget {
  int idSurat;
  SuratKeluarForm({Key? key, required this.idSurat}) : super(key: key);
  @override
  _SuratKeluarFormState createState() => _SuratKeluarFormState();
}

class _SuratKeluarFormState extends State<SuratKeluarForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _kodeController = TextEditingController();
  TextEditingController _noAgendaController = TextEditingController();
  TextEditingController _tujuanController = TextEditingController();
  TextEditingController _isiController = TextEditingController();
  TextEditingController _tglSuratController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();
  TextEditingController _nosuratController = TextEditingController();
  bool isLoading = false;
  String _selecttedJenis = "";
  List<File> _selectedFiles = [];
  bool uploadedfile = false;

  void _handleFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          uploadedfile = true;
          _selectedFiles = result.paths.map((path) => File(path!)).toList();
        });
      }
    } catch (e) {
      print("Error while picking the file: $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _cleardata() {
    setState(() {
      _selectedFiles = [];
      _kodeController.text = "";
      _noAgendaController.text = "";
      _tujuanController.text = "";
      _isiController.text = "";
      _tglSuratController.text = "";
      _keteranganController.text = "";
      _nosuratController.text = "";
      uploadedfile = false;
      _selectedFiles = [];
    });
  }

  
  Future<void> _actionSubmitData() async {
    setState(() {
      isLoading = true;
    });
    var response = widget.idSurat != 0
        ? await SuratRepo.createSuratkeluar(
            _kodeController.text,
            _noAgendaController.text,
            _nosuratController.text,
            _tujuanController.text,
            _isiController.text,
            _tglSuratController.text,
            _keteranganController.text,
            _selecttedJenis,
            _selectedFiles,
          )
        : await SuratRepo.updateSuratkeluar(
            _kodeController.text,
            _noAgendaController.text,
            _nosuratController.text,
            _tujuanController.text,
            _isiController.text,
            _tglSuratController.text,
            _keteranganController.text,
            _selecttedJenis,
            _selectedFiles,
            widget.idSurat,
          );
    if (response.reasonPhrase == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            backgroundColor: Colors.greenAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            content: Text("Save successfully"),
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      _cleardata();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Can\'t save data"),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            backgroundColor: Colors.greenAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            content: Text("Error: ${response.reasonPhrase}"),
          );
        },
      );
      setState(() {
        isLoading = false;
      });
      _cleardata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 20),
                  Icon(Icons.arrow_back_ios_new),
                  SizedBox(width: 10),
                  Text(
                    "Surat Keluar ${widget.idSurat == 0 ? "Tambah" : "Edit"}",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          "https://img.freepik.com/premium-vector/ui-ux-designer-arrangement-interface-elements-application-sites-man-makes-vector_414360-2878.jpg",
                          width: 200,
                        ),
                        SizedBox(height: 10),
                        // Text(
                        //   'Harap Isikan data yang dibutuhkan pada form.',
                        //   textAlign: TextAlign.center,
                        // ),
                        // SizedBox(height: 20),
                        TextFormField(
                          controller: _kodeController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'Kode Klafikasi',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  11.0)), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _noAgendaController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'No Agenda',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  11.0)), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _nosuratController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'No Surat',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  11.0)), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Wajib di isi enter some text';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: _isiController,
                          maxLines:
                              3, // Set to null for unlimited lines, or specify a number
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  11.0)), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                            hintText: 'Enter your text here...',
                            // border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(14.0), // Border radius
                          ),
                          child: DropdownButtonFormField(
                            value: null,
                            items: [
                              DropdownMenuItem(
                                child: Text('SPT~Walikota'),
                                value: '9',
                              ),
                              DropdownMenuItem(
                                child: Text('SPT~Wakil Walikota'),
                                value: '10',
                              ),
                              DropdownMenuItem(
                                child: Text('SPPD~Luar Kota'),
                                value: '12',
                              ),
                              DropdownMenuItem(
                                child: Text('SPPD~Dalam Kota'),
                                value: '13',
                              ),
                              DropdownMenuItem(
                                child: Text('Surat keputusan'),
                                value: '15',
                              ),
                              DropdownMenuItem(
                                child: Text('DIR'),
                                value: '17',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selecttedJenis = value!;
                              });
                              // Handle your value change here
                            },
                            decoration: InputDecoration(
                              labelText: 'Jenis surat',

                              border:
                                  InputBorder.none, // Hide the default border
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Padding inside the dropdown
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Upload file Surat",
                            // style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: TextButton(
                            onPressed: _handleFileUpload,
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  uploadedfile ? Colors.green : Colors.orange,
                            ),
                            child: uploadedfile
                                ? Text(
                                    'File Berhasil diupload ...',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    'Upload File ...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        TextFormField(
                          controller: _isiController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'Isi Surat',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  11.0)), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _tglSuratController,
                          readOnly: true,
                          onTap: () {
                            // Show date picker
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((pickedDate) {
                              if (pickedDate != null) {
                                setState(() {
                                  _tglSuratController.text =
                                      pickedDate.toString().split(' ')[0];
                                });
                              }
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'Tgl Surat',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  11.0)), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select date';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _keteranganController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'Keterangan',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  11.0)), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 14),
                        TextFormField(
                          controller: _tujuanController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    10), // Atur ukuran teks kecil di sini
                            labelText: 'Tujuan Surat',
                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(11.0),
                              ), // Mengatur radius border
                              borderSide: BorderSide(
                                color: Colors.grey, // Warna border
                                width: 1.0, // Ketebalan border
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process your form data here
                          _actionSubmitData();
                        }
                      },
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Loading",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.06,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.04,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
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
