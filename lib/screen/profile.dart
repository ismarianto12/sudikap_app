import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.arrow_back_ios_new),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "Update Profile",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
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
            Button(
              title: "Simpan Surat",
              color: Colors.orange,
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
