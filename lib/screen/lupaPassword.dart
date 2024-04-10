import 'package:flutter/material.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

class lupaPassord extends StatefulWidget {
  const lupaPassord({super.key, required this.title});

  final String title;

  @override
  State<lupaPassord> createState() => _lupaPassordState();
}

class _lupaPassordState extends State<lupaPassord> {
  int _counter = 0;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Lupa Password",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Kirim email verifikasi.",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w100,
                  ),
            ),
            Image.network(
              "https://simpel4.ombudsman.go.id/media/svg/icons/Tools/banerlogin.png",
              width: 300,
            ),
            SizedBox(
              height: 120,
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10), // Atur ukuran teks kecil di sini
                        labelText: 'Email Verifikasi',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => DashboardScreen()),
                          // );
                        },
                        child: Button(
                            title: "Kirim tautan verifikasi",
                            color: const Color.fromARGB(255, 0, 255, 234))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
