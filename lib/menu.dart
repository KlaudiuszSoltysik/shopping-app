import "package:flutter/material.dart";
import "components.dart";
import 'package:provider/provider.dart';
import 'providers.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepOrangeAccent, Colors.amber],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "allegro",
              textAlign: TextAlign.center,
              style: kBigText,
            ),
            SizedBox(height: 40),
            if (Provider.of<UserProvider>(context, listen: false).userEmail ==
                "")
              button(
                "log in",
                () {
                  Navigator.pushNamed(context, "/log-in");
                },
              ),
            SizedBox(height: 20),
            if (Provider.of<UserProvider>(context, listen: false).userEmail ==
                "")
              button(
                "register",
                () {
                  Navigator.pushNamed(context, "/register");
                },
              ),
            SizedBox(height: 20),
            button(
              "continue without logging in",
              () {
                Navigator.pushNamed(context, "/shop");
              },
            ),
            SizedBox(height: 40),
            Icon(
              Icons.shopping_bag_outlined,
              size: 240,
              color: Colors.white.withOpacity(0.9),
            )
          ],
        ),
      ),
    );
  }
}
