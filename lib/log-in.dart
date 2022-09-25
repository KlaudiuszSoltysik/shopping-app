import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                  "We missed you!",
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
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) => Navigator.pushNamed(context, "/shop")
                            .onError((error, stackTrace) => {}));
                  },
                  text: "log in",
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
