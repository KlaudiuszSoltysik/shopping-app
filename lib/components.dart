import "package:flutter/material.dart";
import 'package:flutter/services.dart';

const kBigText = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.none,
  fontSize: 80,
  fontWeight: FontWeight.normal,
  fontFamily: "Overpass",
);

const kMediumText = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.none,
  fontSize: 40,
  fontWeight: FontWeight.normal,
  fontFamily: "Overpass",
);

const kSmallText = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.none,
  fontSize: 20,
  fontWeight: FontWeight.normal,
  fontFamily: "Overpass",
);

GestureDetector button(String text, VoidCallback function) {
  return GestureDetector(
    onTap: function,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 25,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.normal,
              fontFamily: "Overpass",
            ),
          ),
        ),
      ),
    ),
  );
}

Padding textField(String text, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter some text";
        }
      },
      controller: controller,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.teal),
        labelText: text,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
    ),
  );
}

TextFormField authTextField(String text, IconData icon, bool isPassword,
    TextEditingController controller) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter some text";
      }
      return null;
    },
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: false,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      errorStyle: TextStyle(color: Colors.teal),
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
          borderSide: BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

GestureDetector itemCard(String id, String title, String price,
    List<dynamic> imageNames, String user) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.network(
                "https://wallpaperaccess.com/full/254908.jpg",
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Overpass",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$price PLN",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontSize: 35,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Overpass",
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Future<String> downloadURL(String imageName) async {
//   return await storage.ref(imageName).getDownloadURL();
// }

class Item {
  String id;
  String title;
  String description;
  String price;
  List<String> imageNames;
  String? user;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imageNames": imageNames,
        "user": user,
      };

  static Item fromJson(Map<String, dynamic> json) => Item(
      json["id"],
      json["title"],
      json["description"],
      json["price"],
      json["imageNames"],
      json["user"]);

  Item(this.id, this.title, this.description, this.price, this.imageNames,
      this.user) {}
}
