import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:shopping_app/providers.dart";
import "menu.dart";
import "log-in.dart";
import "register.dart";
import "shop.dart";
import "reset.dart";
import "add.dart";
import 'product.dart';
import 'account.dart';
import 'message.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        "/reset": (context) => Reset(),
        "/add": (context) => Add(),
        "/product": (context) => Product(),
        "/account": (context) => Account(),
        "/message": (context) => Message(),
      },
    );
  }
}
