import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/components/Comloading.dart';
import 'package:sistem_kearsipan/components/SelectData.dart';
import 'package:sistem_kearsipan/model/SelectModel.dart';
import 'package:sistem_kearsipan/utils/reques.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class SatuanForm extends StatefulWidget {
  final int id;
  SatuanForm({Key? key, required this.id}) : super(key: key);

  @override
  State<SatuanForm> createState() => _SatuanFormState();
}

class _SatuanFormState extends State<SatuanForm> {
  TextEditingController namaSatuan = TextEditingController();
  TextEditingController kodesatuan = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController klasifikasi = TextEditingController();
  bool loading = false;

  String _selectedBank = '';
  // List<SelectModel> _bankData = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  List<SelectModel> _bankData = [
    SelectModel(valueCom: "Kosong", label: "Kosong"),
  ];

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

  Future<void> _submitData() async {
    showLoading(true);
    setState(() {
      loading = true;
    });
    try {
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
        shadowColor: null,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 222, 179, 8),
              ),
              focusColor: Colors.red,
              splashColor: Colors.red,
              color: Colors.red,
              onPressed: () {},
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
        title: Text(
          widget.id != 0 ? 'Edit Satuan Arsip' : 'Tambah Satuan Arsip',
          style: TextStyle(
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
                      children: [
                        InputApp(
                          context,
                          'Nama Satuan',
                          namaSatuan,
                        ),
                        SizedBox(height: 25),
                        InputApp(
                          context,
                          'Kode Satuan',
                          kodesatuan,
                        ),
                        SizedBox(height: 25),
                        InputApp(
                          context,
                          'Keterangan Satuan',
                          keterangan,
                        ),
                        SizedBox(height: 25),
                        WidgetSelect(
                          context,
                          _bankData,
                          _selectedBank,
                          (String? newSelectedBank) {
                            setState(() {
                              _selectedBank = newSelectedBank!;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
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
