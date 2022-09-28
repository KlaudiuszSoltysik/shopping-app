// ignore_for_file: prefer_const_constructors

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:rflutter_alert/rflutter_alert.dart";

class UserProvider extends ChangeNotifier {
  late String? _email;

  Future googleLogIn(dynamic context) async {
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    _email = googleUser.email;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.popAndPushNamed(context, "/shop");
    } on FirebaseAuthException catch (error) {
      await Alert(
              context: context,
              title: "SOMETHING WENT WRONG",
              desc: error.message)
          .show();
    }
    notifyListeners();
    Navigator.popAndPushNamed(context, "/shop");
  }

  Future emailLogIn(String email, String password, dynamic context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _email = FirebaseAuth.instance.currentUser?.email;

      Navigator.popAndPushNamed(context, "/shop");
    } on FirebaseAuthException catch (error) {
      await Alert(
              context: context,
              title: "SOMETHING WENT WRONG",
              desc: error.message)
          .show();
    }
    notifyListeners();
    Navigator.popAndPushNamed(context, "/shop");
  }

  Future emailRegister(String email, String password, dynamic context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await Alert(context: context, title: "Account created").show();

      Navigator.popAndPushNamed(context, "/log-in");
    } on FirebaseAuthException catch (error) {
      await Alert(context: context, title: "Try again", desc: error.message)
          .show();
    }
    notifyListeners();
  }

  Future resetPassword(email, context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      await Alert(
              context: context,
              title: "EMAIL SENT",
              desc: "Check your $email account")
          .show();

      Navigator.popUntil(context, ModalRoute.withName("/"));
    } on FirebaseAuthException catch (error) {
      await Alert(
              context: context,
              title: "SOMETHING WENT WRONG",
              desc: error.message)
          .show();
    }
    notifyListeners();
  }
}
