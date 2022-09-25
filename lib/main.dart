import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'menu.dart';
import 'log-in.dart';
import 'register.dart';

void main() {
  runApp(
    MyApp(
        // MultiProvider(
        //   providers: [],
        //   child: MyApp(),
        ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => Menu(),
        "/log-in": (context) => LogIn(),
        "/register": (context) => Register(),
      },
    );
  }
}
