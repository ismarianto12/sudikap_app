import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_kearsipan/bloc/bloc/authenticate_bloc.dart';
import 'package:sistem_kearsipan/bloc/login_bloc.dart';
import 'package:sistem_kearsipan/components/splashScreen.dart';
import 'package:sistem_kearsipan/repository/loginRepo.dart';
import 'package:sistem_kearsipan/route/route.dart';
import 'package:sistem_kearsipan/screen/dashboard.dart';
import 'package:sistem_kearsipan/screen/lupaPassword.dart';
import 'package:sistem_kearsipan/widget/Button.dart';

void main() {
  final loginrepo = loginRepo();
  runApp(BlocProvider(
    create: (context) {
      return AuthenticateBloc(loginrepo: loginrepo)..add(AppStarted());
    },
    child: MyApp(loginrepo: loginrepo),
  ));
}

class MyApp extends StatefulWidget {
  final loginRepo loginrepo;

  const MyApp({Key? key, required this.loginrepo}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading =
      false; // State untuk menentukan apakah dialog loading ditampilkan atau tidak

  @override
  void initState() {
    final loginrepo = loginRepo();
    AuthenticateBloc(loginrepo: loginrepo)..add(AppStarted());
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
    return BlocProvider(
      create: (context) => AuthenticateBloc(loginrepo: widget.loginrepo),
      child: MaterialApp(
        onGenerateRoute: RouteAplikasi.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Sistem Kearsipan.',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocListener<AuthenticateBloc, AuthenticateState>(
          listener: (context, state) {
            // print("status state login : ${state}");
            if (state is AuthenticateAuthenticated) {
              // return DashboardScreen();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
            } else if (state is AuthenticateInitial) {
              // return SplashScreen();
              Navigator.of(context).pushReplacementNamed('/login');
            } else if (state is AuthenticateunAuthenticated) {
              // return MyHomePage(
              //     title: "Logout berhasil, silahkan login kembali");
              Navigator.of(context).pushReplacementNamed('/login');
            }
          },
          child: MyHomePage(
            title: "Login Apps",
          ),
        ),
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
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  bool closeinfo = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginrepo = loginRepo();
    return BlocProvider(
      create: (context) => LoginBloc(
          authenticateBloc: BlocProvider.of<AuthenticateBloc>(context),
          loginrepo: loginrepo),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Username dan password Salah ${state.error}'),
              backgroundColor: Colors.red,
            ));
          } else if (state is LoginLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
            state is LoginLoading
                ? showDialog(
                    context: context,
                    barrierDismissible: state is LoginLoading
                        ? true
                        : false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Loading...'),
                          ],
                        ),
                      );
                    },
                  )
                : null;
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            print(state);
            // if (state is LoginInitial) {
            return Scaffold(
              body: SingleChildScrollView(
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
                                print(state);
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    closeinfo = false;
                                  });
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginSubmitted(
                                        username: username.text,
                                        password: password.text),
                                  );
                                  // if (state is AuthenticateAuthenticated) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => DashboardScreen(),
                                  //     ),
                                  //   );
                                  // }
                                }
                              },
                              child:
                                  Button(title: "Login", color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: state is LoginInitial
                          ? CircularProgressIndicator()
                          : null,
                    ),
                  ],
                ),
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
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    username.text;
    password.text;
  }
}
