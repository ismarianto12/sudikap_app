import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/components/Comloading.dart';
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

  final _formKey = GlobalKey<FormState>();

  Future<void> _submitData() async {
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
    } catch (e) {
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

  void showLoading(bool show) {
    if (show) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(child: Comloading(title: "Please Wait ..."));
        },
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: null,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Color.fromARGB(255, 0, 0, 0),
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        InputApp(
                          context,
                          'Nama Satuan',
                          namaSatuan,
                        ),
                        SizedBox(height: 10),
                        InputApp(
                          context,
                          'Kode Satuan',
                          kodesatuan,
                        ),
                        SizedBox(height: 10),
                        InputApp(
                          context,
                          'Keterangan Satuan',
                          keterangan,
                        ),
                        SizedBox(height: 10),
                        InputApp(
                          context,
                          'Klasifikasi Satuan',
                          klasifikasi,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget InputApp(
      BuildContext context, String label, TextEditingController controller) {
    return Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: '${label}',
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field Required';
            }
            return null;
          },
        ),
      ),
    );
  }
}
