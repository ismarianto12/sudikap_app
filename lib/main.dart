import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_kearsipan/bloc/bloc/authenticate_bloc.dart';
import 'package:sistem_kearsipan/bloc/login_bloc.dart';
import 'package:sistem_kearsipan/components/Comloading.dart';
import 'package:sistem_kearsipan/components/splashScreen.dart';
import 'package:sistem_kearsipan/repository/loginRepo.dart';
import 'package:sistem_kearsipan/route/route.dart';
import 'package:sistem_kearsipan/screen/dashboard.dart';
import 'package:sistem_kearsipan/screen/lupaPassword.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

void main() {
  final loginrepo = loginRepo();
  runApp(MyApp(loginrepo: loginrepo));
}

class MyApp extends StatefulWidget {
  final loginRepo loginrepo;

  const MyApp({Key? key, required this.loginrepo}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String apptoken = '';
  bool _isLoading =
      false; // State untuk menentukan apakah dialog loading ditampilkan atau tidak

  @override
  Future<String?> getTokenapp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  void initState() {
    // final loginrepo = loginRepo();
    // AuthenticateBloc(loginrepo: loginrepo)..add(AppStarted());
    super.initState();
  }

  Widget _buildLoadingWidget() {
    return _isLoading
        ? _buildLoadingDialog()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading..."),
            ],
          );
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      onGenerateRoute: RouteAplikasi.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Sistem Kearsipan.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: getTokenapp(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            String? tokenya = snapshot.data;
            if (tokenya != null) {
              return DashboardScreen();
            } else {
              return SplashScreen();
            }
          }
        },
      ),
    );
  }

  Widget _buildLoadingDialog() {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('Loading...'),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late loginRepo applogin;
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  bool closeinfo = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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

  @override
  void _submitForm() async {
    showLoading(true);
    var response = await loginRepo.loginApi(username.text, password.text);
    print("params ${response}");

    try {
      if (response['success']) {
        showLoading(false);

        Route route = MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        );
        Navigator.push(context, route);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Gagal'),
              content: const Text('Silahkan Check username dan password.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        showLoading(false);
      }
    } catch (e) {
      showLoading(false);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Gagal'),
            content: Text("${e}"),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Future<String?> getTokenapp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: getTokenapp(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            String? tokenya = snapshot.data;
            if (tokenya == null) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "SUDIKAP APPS",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Satu layanan Arsip Terpadu.",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w100,
                              ),
                    ),
                    Image.network(
                      "https://simpel4.ombudsman.go.id/media/svg/icons/Tools/banerlogin.png",
                      width: 300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: username,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal:
                                        10), // Atur ukuran teks kecil di sini
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ), // Mengatur radius border
                                  borderSide: BorderSide(
                                    color: Colors.grey, // Warna border
                                    width: 1.0, // Ketebalan border
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: password,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal:
                                        10), // Atur ukuran teks kecil di sini
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => lupaPassord(
                                        title: 'Lupa Password',
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Lupa Kata Sandi ? ")),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _submitForm();
                                  setState(() {
                                    closeinfo = false;
                                  });
                                }
                              },
                              child:
                                  Button(title: "Login", color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return DashboardScreen();
            }
          }
        },
      ),
    );
    // }
    // if (state is LoginFailure) {
    //   return Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: 50,
    //           ),
    //           Text(
    //             "SUDIKAP APPS",
    //             style: Theme.of(context)
    //                 .textTheme
    //                 .headlineSmall!
    //                 .copyWith(
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             "Satu layanan Arsip Terpadu.",
    //             style: Theme.of(context)
    //                 .textTheme
    //                 .headlineSmall!
    //                 .copyWith(
    //                   fontWeight: FontWeight.w100,
    //                 ),
    //           ),
    //           Image.network(
    //             "https://simpel4.ombudsman.go.id/media/svg/icons/Tools/banerlogin.png",
    //             width: 300,
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           closeinfo
    //               ? Container()
    //               : Container(
    //                   height:
    //                       MediaQuery.sizeOf(context).height * 0.10,
    //                   width: MediaQuery.sizeOf(context).width * 0.9,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(
    //                       Radius.circular(10),
    //                     ),
    //                     color: Color.fromARGB(133, 5, 70, 119),
    //                   ),
    //                   child: Row(
    //                     mainAxisAlignment:
    //                         MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Expanded(
    //                         child: Flexible(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Text(
    //                               '${state.error}',
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       // Marquee(
    //                       //   key: key,
    //                       //   title: this.title,
    //                       //   style: TextStyle(
    //                       //     color: Colors.white,
    //                       //     leadingDistribution: TextLeadingDistribution.even,
    //                       //     // wordSpacing: 10.0,
    //                       //   ),
    //                       // ),
    //                       // MarqueeWidget(
    //                       //   direction: Axis.horizontal,
    //                       //   child: Text("This text is to long to be shown in just one line "),
    //                       // ),

    //                       GestureDetector(
    //                         onTap: () => {
    //                           setState(() {
    //                             closeinfo = true;
    //                           })
    //                         },
    //                         child: Icon(
    //                           Icons.close,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //           Form(
    //             key: _formKey,
    //             child: Padding(
    //               padding: const EdgeInsets.all(18.0),
    //               child: Column(
    //                 children: [
    //                   TextFormField(
    //                     controller: username,
    //                     decoration: InputDecoration(
    //                       contentPadding: EdgeInsets.symmetric(
    //                           vertical: 10,
    //                           horizontal:
    //                               10), // Atur ukuran teks kecil di sini
    //                       labelText: 'Username',
    //                       // prefixIcon: Icon(Icons.person),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(
    //                             Radius.circular(
    //                                 4.0)), // Mengatur radius border
    //                         borderSide: BorderSide(
    //                           color: Colors.grey, // Warna border
    //                           width: 1.0, // Ketebalan border
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 30,
    //                   ),
    //                   TextFormField(
    //                     obscureText: true,
    //                     controller: password,
    //                     decoration: InputDecoration(
    //                       contentPadding: EdgeInsets.symmetric(
    //                           vertical: 10,
    //                           horizontal:
    //                               10), // Atur ukuran teks kecil di sini
    //                       labelText: 'Password',
    //                       prefixIcon: Icon(Icons.password),
    //                       border: OutlineInputBorder(),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 20,
    //                   ),
    //                   GestureDetector(
    //                       onTap: () {
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => lupaPassord(
    //                               title: 'Lupa Password',
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                       child: Text("Lupa Kata Sandi ? ")),
    //                   SizedBox(
    //                     height: 10,
    //                   ),
    //                   GestureDetector(
    //                     onTap: () {
    //                       if (_formKey.currentState!.validate()) {
    //                         setState(() {
    //                           closeinfo = false;
    //                         });
    //                         BlocProvider.of<LoginBloc>(context).add(
    //                           LoginSubmitted(
    //                               username: username.text,
    //                               password: password.text),
    //                         );
    //                       }
    //                     },
    //                     child: Button(
    //                         title: "Login", color: Colors.orange),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Container(
    //             child: state is LoginLoading
    //                 ? CircularProgressIndicator()
    //                 : CircularProgressIndicator(),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    // if (state is AuthenticateAuthenticated) {
    //   return const DashboardScreen();
    // }
    // return Container();
  }

  @override
  void dispose() {
    super.dispose();
    username.text;
    password.text;
  }
}
