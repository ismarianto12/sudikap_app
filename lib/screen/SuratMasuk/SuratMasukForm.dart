import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SuratMasukForm extends StatefulWidget {
  int idSurat;

  SuratMasukForm({this.idSurat = 0});

  @override
  _SuratMasukFormState createState() => _SuratMasukFormState();
}

class _SuratMasukFormState extends State<SuratMasukForm> {
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
    });
  }

  Future<void> _actionSubmitData() async {
    setState(() {
      isLoading = true;
    });
    var sendata = {
      'kode': _kodeController.text,
      'no_agenda': _noAgendaController.text,
      'no_surat': _nosuratController.text,
      'tujuan': _tujuanController.text,
      'isi_surat': _isiController.text,
      'tlg_surat': _tglSuratController.text,
      'keterangan': _keteranganController.text,
      'id_jenis_surat': '10'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.88.51/backend_arsip/public/api/v1/surat_masuk/insert'),
    );
    sendata.forEach((key, value) {
      request.fields[key] = value;
    });
    _selectedFiles.forEach((file) {
      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        file.readAsBytesSync(),
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    });
    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
              backgroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: Text("Save successfully"),
            );
          },
        );
        setState(() {
          isLoading = false;
        });
        _cleardata();
        print('Response body: $responseBody');
      } else {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Gagal"),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
              backgroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: Text("${responseBody}"),
            );
          },
        );
        print(
            'Failed to upload data and file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print('Error uploading data and file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.share),
          )
        ],
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
        title: Text('Form Surat'),
        actionsIconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqET5aqbDoPcjK-3A9kmsoOQgm2XjV6o_yArEVcP5UiQ&s",
                          width: 200,
                        ),
                        SizedBox(height: 10),
                        // Text(
                        //   'Harap Isikan data yang dibutuhkan pada form.',
                        //   textAlign: TextAlign.center,
                        // ),
                        // SizedBox(height: 20),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          child: TextFormField(
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          child: TextFormField(
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          child: TextFormField(
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
                          height: MediaQuery.sizeOf(context).height * 0.07,
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
                mainAxisAlignment: MainAxisAlignment.start,
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
