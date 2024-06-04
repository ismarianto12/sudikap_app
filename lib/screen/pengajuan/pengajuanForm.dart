import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/components/Comloading.dart';
import 'package:sistem_kearsipan/components/SelectData.dart';
import 'package:sistem_kearsipan/model/SelectModel.dart';
import 'package:sistem_kearsipan/screen/dashboard.dart';
import 'package:sistem_kearsipan/utils/reques.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class pengajuanForm extends StatefulWidget {
  final int id;
  pengajuanForm({Key? key, required this.id}) : super(key: key);

  @override
  State<pengajuanForm> createState() => _pengajuanFormState();
}

class _pengajuanFormState extends State<pengajuanForm> {
  TextEditingController namaSatuan = TextEditingController();
  TextEditingController kodesatuan = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController klasifikasi = TextEditingController();
  bool loading = false;
  String? _selectedBank = '';
  List<SelectModel> _bankData = [];

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    print("selected ${_selectedBank}");
    _callJenisarsip();
  }

  void showLoading(loading) {
    loading
        ? showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(child: Comloading(title: "Pleae Wait"));
            },
          )
        : null;
  }

  // List<SelectModel> _bankData = [
  //   SelectModel(valueCom: '', label: ''),
  //   SelectModel(label: 'Arsip Surat Keputusan Rektor', valueCom: '12'),
  //   SelectModel(label: 'Arsip Surat Masuk Eksternal', valueCom: '1'),
  //   SelectModel(label: 'Arsip Surat Masuk Internal	', valueCom: '4'),
  //   SelectModel(label: 'Arsip Surat Keluar', valueCom: '6'),
  // ];
  Future<List<SelectModel>> _callJenisarsip() async {
    try {
      var response = await postData({'getype': 'master'}, 'master/jenisarsip');
      print(response);
      List<dynamic> json = jsonDecode(response!)['data'];
      List<SelectModel> datas = json
          .map(
            (dynamic item) => SelectModel(
              valueCom: item['id_jenis'],
              label: item['jenis_arsip'],
            ),
          )
          .toList();
      print("datas: ${datas}");
      setState(() {
        _bankData = datas;
      });

      return datas;
    } catch (e) {
      setState(() {
        _bankData = [
          SelectModel(valueCom: '1', label: 'Failed Load data'),
          // SelectModel(label: 'Arsip Surat Keputusan Rektor', valueCom: '12'),
          // SelectModel(label: 'Arsip Surat Masuk Eksternal', valueCom: '1'),
          // SelectModel(label: 'Arsip Surat Masuk Internal', valueCom: '4'),
          // SelectModel(label: 'Arsip Surat Keluar', valueCom: '6'),
        ];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.amberAccent,
          content: Text("$e"),
        ),
      );
      return _bankData;
    }
  }

  Future<void> _submitData() async {
    showLoading(true);
    setState(() {
      loading = true;
    });
    try {
      print({
        'namasatuan': namaSatuan.text,
        'keterangan': keterangan.text,
        'kodesatuan': kodesatuan.text,
        'klasifikasi': klasifikasi.text,
        'id_jenisarsip': _selectedBank,
      });
      var response = await postData({
        'namasatuan': namaSatuan.text,
        'keterangan': keterangan.text,
        'kodesatuan': kodesatuan.text,
        'klasifikasi': klasifikasi.text,
      }, 'satuan/store');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data berhasil disimpan ${response}"),
        ),
      );
      showLoading(false);
    } catch (e) {
      showLoading(false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error: ${e}"),
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: null,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 222, 179, 8),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
        title: Text(
          widget.id != 0 ? 'Edit Pengajuan Arsips' : 'Tambah Pengajuan Arsip',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        shape: Border(bottom: BorderSide.none),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputApp(context, "Kode", kodesatuan),
                        SizedBox(
                          height: 10,
                        ),
                        InputApp(context, "Nama arsip", kodesatuan),
                        SizedBox(
                          height: 10,
                        ),
                        InputApp(context, "Jumlah", kodesatuan),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Satuan Arsip : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        WidgetSelect(
                          context,
                          _bankData,
                          _selectedBank,
                          (String? newSelectedBank) {
                            setState(() {
                              _selectedBank = newSelectedBank;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Jenis Arsip : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        WidgetSelect(
                          context,
                          _bankData,
                          _selectedBank,
                          (String? newSelectedBank) {
                            setState(() {
                              _selectedBank = newSelectedBank;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            // bor
                            border:
                                Border.all(width: 0.50, color: Colors.black),

                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              maxLines: 6, //or null
                              decoration: InputDecoration.collapsed(
                                  hintText: "Catatan"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    showLoading(true);
                    _submitData();
                  }
                },
                child: Button(
                  title: "Simpan Data",
                  color: Color.fromARGB(255, 4, 110, 152),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget InputApp(
      BuildContext context, String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        errorStyle: TextStyle(
          fontSize: 14.0,
        ), // Mengurangi ukuran font untuk error
        labelText: '${label}',
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 12.0), // Mengatur padding
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              10.0), // Mengurangi border radius menjadi 15.0
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Mengurangi border radius menjadi 15.0
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              15.0), // Mengurangi border radius menjadi 15.0
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      style: TextStyle(color: Colors.black),
      validator: (value) {
        if (value!.isEmpty) {
          return '\u26A0 Field is empty.';
        }
        return null;
      },
    );
  }
}
