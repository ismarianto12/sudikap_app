import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/repository/loginRepo.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List editdata = [];
  bool loading = true;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController ulangipassword = TextEditingController();
  final TextEditingController passwordlama = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Future<dynamic> getDataEdit() async {
    var responsedata = await loginRepo.getuserData();
    print(responsedata);
    setState(() {
      editdata = responsedata;
    });
  }

  void submitData() async {
    setState(() {
      loading = true;
    });
    var status = await loginRepo.updatePassword(username.text, password.text);
    if (password.text != ulangipassword.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Ok'),
              ),
            ],
            title: Text(
              "Password tidak sama silahkan diulangi",
            ),
          );
        },
      );
    }
    if (status.responseCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Informasi'),
            content: Text('Username dan password berhasil di update'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Tutup dialog tanpa logout
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('${status.body}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Tutup dialog tanpa logout
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  void initState() {
    getDataEdit().then((_) {
      username.text = "${editdata[0]['username']}";
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0, // Menghilangkan bayangan di bawah appbar
        backgroundColor: Color.fromARGB(225, 255, 255, 255),
        actions: <Widget>[],
        title: Text(
          'Update Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
        // Menghilangkan border bawah
        shape: Border(bottom: BorderSide.none),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        Image.network(
                          "https://img.freepik.com/premium-vector/ui-ux-designer-arrangement-interface-elements-application-sites-man-makes-vector_414360-2878.jpg",
                          width: 200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordlama,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            labelText: 'Password Lama',
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
                        TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            labelText: 'Password Baru',
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
                        TextFormField(
                          controller: ulangipassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            labelText: 'Konfirmasi Password Baru',
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
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  submitData();
                }
              },
              child: Button(
                title: "Simpan Surat",
                color: Color.fromARGB(255, 4, 110, 152),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
