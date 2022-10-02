import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "components.dart";
import "providers.dart";

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                  "Register to use our service",
                  textAlign: TextAlign.center,
                  style: kMediumText,
                ),
                SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: authTextField(
                              "email",
                              Icons.account_circle_rounded,
                              false,
                              emailController)),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: authTextField(
                            "password", Icons.lock, true, passwordController),
                      ),
                    ],
                  ),
                ),
                !isLoading
                    ? button(
                        "register",
                        () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Provider.of<UserProvider>(context, listen: false)
                                .emailRegister(emailController.text,
                                    passwordController.text, context);
                          }
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
