import 'package:flutter/material.dart';
import 'components.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrangeAccent, Colors.amber],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  "Allegro",
                  textAlign: TextAlign.center,
                  style: kBigText,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Register to use our service",
                  textAlign: TextAlign.center,
                  style: kMediumText,
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 20),
                const SizedBox(height: 40),
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 240,
                  color: Colors.white.withOpacity(0.9),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
