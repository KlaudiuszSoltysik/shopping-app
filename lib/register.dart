import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                  "allegro",
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: authTextField("email", Icons.account_circle_rounded,
                      false, _emailController),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: authTextField(
                      "password", Icons.lock, true, _passwordController),
                ),
                Button(
                  function: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then(
                            (value) => Navigator.pushNamed(context, "/log-in"));
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
        ),
      ),
    );
  }
}
