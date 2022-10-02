import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:rflutter_alert/rflutter_alert.dart";

class UserProvider extends ChangeNotifier {
  late String? userEmail = "";

  Future googleLogIn(dynamic context) async {
    final googleUser = await GoogleSignIn().signIn();

    userEmail = googleUser?.email;

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.popAndPushNamed(context, "/shop");
    } on FirebaseAuthException catch (error) {
      await Alert(
              context: context,
              title: "SOMETHING WENT WRONG",
              desc: error.message)
          .show();
      Navigator.popAndPushNamed(context, "/log-in");
    }
    notifyListeners();
  }

  Future emailLogIn(String email, String password, dynamic context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      userEmail = FirebaseAuth.instance.currentUser?.email;

      Navigator.popAndPushNamed(context, "/shop");
    } on FirebaseAuthException catch (error) {
      await Alert(
              context: context,
              title: "SOMETHING WENT WRONG",
              desc: error.message)
          .show();
      Navigator.popAndPushNamed(context, "/log-in");
    }
    notifyListeners();
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
      Navigator.popAndPushNamed(context, "/register");
    }
    notifyListeners();
  }

  Future resetPassword(String email, dynamic context) async {
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

  Future logout(dynamic context) async {
    await FirebaseAuth.instance.signOut();
    userEmail = "";
    Navigator.pop(context);
    notifyListeners();
  }
}
