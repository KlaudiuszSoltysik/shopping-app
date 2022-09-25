import 'package:flutter/material.dart';
import 'components.dart';

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
            const Text(
              "allegro",
              textAlign: TextAlign.center,
              style: kBigText,
            ),
            const SizedBox(height: 40),
            Button(
              function: () {
                Navigator.pushNamed(context, "/log-in");
              },
              text: "log in",
            ),
            const SizedBox(height: 20),
            Button(
              function: () {
                Navigator.pushNamed(context, "/register");
              },
              text: "register",
            ),
            const SizedBox(height: 40),
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
