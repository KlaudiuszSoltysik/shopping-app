import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'menu.dart';
import 'log-in.dart';
import 'register.dart';
import 'shop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      theme: ThemeData(fontFamily: "Overpass"),
      initialRoute: "/",
      routes: {
        "/": (context) => Menu(),
        "/log-in": (context) => LogIn(),
        "/register": (context) => Register(),
        "/shop": (context) => Shop(),
      },
    );
  }
}
