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
  runApp(MyApp(loginrepo: loginrepo));
}

class MyApp extends StatelessWidget {
  final loginRepo loginrepo;
  const MyApp({super.key, required this.loginrepo});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return BlocProvider(
      create: (context) => AuthenticateBloc(loginrepo: loginrepo),
      child: MaterialApp(
        onGenerateRoute: RouteAplikasi.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Sistem Kearsipan.',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) {
            if (state is AuthenticateInitial) {
              return SplashScreen();
            }
            if (state is AuthenticateAuthenticated) {
              return DashboardScreen();
            }
            if (state is AuthenticateunAuthenticated) {
              // return MyHomePage(title: "and berhasil lgoout aplikasi");
              return CircularProgressIndicator();
            }
            return CircularProgressIndicator();
          },
        ),
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
      create: (context) => LoginBloc(loginrepo: loginrepo),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginFailure) {
            print('login failed');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocProvider(
          create: (context) => LoginBloc(loginrepo: loginrepo),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              print(state);
              if (state is LoginInitial) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "SUDIKAP APPS",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Satu layanan Arsip Terpadu.",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
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
                                    // prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              4.0)), // Mengatur radius border
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
                                      // BlocProvider.of<LoginBloc>(context).add(
                                      //   LoginSubmitted(
                                      //       username: username.text,
                                      //       password: password.text),
                                      // );
                                      setState(() {
                                        closeinfo = false;
                                      });
                                      BlocProvider.of<LoginBloc>(context).add(
                                        LoginSubmitted(
                                            username: username.text,
                                            password: password.text),
                                      );
                                    }
                                  },
                                  child: Button(
                                      title: "Login", color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is LoginLoading) {
                return CircularProgressIndicator();
              } else if (state is LoginFailure) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "SUDIKAP APPS",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Satu layanan Arsip Terpadu.",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
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
                        closeinfo
                            ? Container()
                            : Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.10,
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Color.fromARGB(133, 5, 70, 119),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${state.error}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Marquee(
                                    //   key: key,
                                    //   title: this.title,
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     leadingDistribution: TextLeadingDistribution.even,
                                    //     // wordSpacing: 10.0,
                                    //   ),
                                    // ),
                                    // MarqueeWidget(
                                    //   direction: Axis.horizontal,
                                    //   child: Text("This text is to long to be shown in just one line "),
                                    // ),

                                    GestureDetector(
                                      onTap: () => {
                                        setState(() {
                                          closeinfo = true;
                                        })
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
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
                                    // prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              4.0)), // Mengatur radius border
                                      borderSide: BorderSide(
                                        color: Colors.grey, // Warna border
                                        width: 1.0, // Ketebalan border
                                      ),
                                    ),
                                  ),
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
                                      setState(() {
                                        closeinfo = false;
                                      });
                                      BlocProvider.of<LoginBloc>(context).add(
                                        LoginSubmitted(
                                            username: username.text,
                                            password: password.text),
                                      );
                                    }
                                  },
                                  child: Button(
                                      title: "Login", color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
