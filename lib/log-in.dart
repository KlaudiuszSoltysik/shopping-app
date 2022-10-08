import "package:flutter/material.dart";
import "components.dart";
import "package:provider/provider.dart";
import "providers.dart";

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
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
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: authTextField(
                            "email",
                            Icons.account_circle_rounded,
                            false,
                            emailController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: authTextField(
                            "password", Icons.lock, true, passwordController),
                      ),
                    ],
                  ),
                ),
                !isLoading
                    ? button(
                        "log in",
                        () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Provider.of<UserProvider>(context, listen: false)
                                .emailLogIn(emailController.text,
                                    passwordController.text, context);
                          }
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Forgot your password? ",
                        style: kSmallText,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/reset");
                        },
                        child: const Text(
                          "Reset",
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
                const Padding(
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
