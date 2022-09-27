import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components.dart';
import 'providers.dart';

class Reset extends StatefulWidget {
  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                  "We'll send you email with next steps!",
                  textAlign: TextAlign.center,
                  style: kMediumText,
                ),
                SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: authTextField("email", Icons.account_circle_rounded,
                        false, emailController),
                  ),
                ),
                Button(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      Provider.of<UserProvider>(context, listen: false)
                          .resetPassword(emailController.text, context);
                    }
                  },
                  text: "reset password",
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
        ),
      ),
    );
  }
}
