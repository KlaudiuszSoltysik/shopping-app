import 'package:flutter/material.dart';
import 'components.dart';
import 'package:provider/provider.dart';
import 'providers.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

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
                Text(
                  "allegro",
                  textAlign: TextAlign.center,
                  style: kBigText,
                ),
                SizedBox(height: 20),
                Text(
                  "We missed you!",
                  textAlign: TextAlign.center,
                  style: kMediumText,
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: authTextField("email", Icons.account_circle_rounded,
                      false, emailController),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: authTextField(
                      "password", Icons.lock, true, passwordController),
                ),
                !isLoading
                    ? Button(
                        function: () {
                          setState(() {
                            isLoading = true;
                          });
                          Provider.of<UserProvider>(context, listen: false)
                              .emailLogIn(emailController.text,
                                  passwordController.text, context);
                        },
                        text: "log in",
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Forgot your password? ",
                        style: kSmallText,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/reset");
                        },
                        child: Text(
                          "Reset password",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontFamily: "Overpass",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Or log in with",
                    textAlign: TextAlign.center,
                    style: kSmallText,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        Provider.of<UserProvider>(context, listen: false)
                            .googleLogIn(context);
                      },
                      icon: Image.asset("assets/google_icon.png"),
                      iconSize: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
