import 'package:flutter/material.dart';

const kBigText = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.none,
  fontSize: 80,
  fontFamily: "Overpass",
);

const kMediumText = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.none,
  fontSize: 40,
  fontFamily: "Overpass",
);

const kSmallText = TextStyle(
  color: Colors.black,
  decoration: TextDecoration.none,
  fontSize: 20,
  fontFamily: "Overpass",
);

class Button extends StatelessWidget {
  final String text;
  final VoidCallback function;

  Button({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 25,
                color: Colors.white.withOpacity(0.9),
                fontFamily: "Overpass",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextField authTextField(String text, IconData icon, bool isPassword,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: false,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}
