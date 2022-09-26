import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
    Navigator.popAndPushNamed(context, "/shop");
  }

  Future emailLogIn(String email, String password, dynamic context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    _email = FirebaseAuth.instance.currentUser?.email;

    notifyListeners();
    Navigator.popAndPushNamed(context, "/shop");
  }

  Future emailRegister(String email, String password, dynamic context) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    notifyListeners();
    Navigator.popAndPushNamed(context, "/log-in");
  }

  Future resetPassword(email, context) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Navigator.pop(context);
  }
}
