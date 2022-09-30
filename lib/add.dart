// ignore_for_file: prefer_uctors

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "components.dart";
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Add extends StatefulWidget {
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;

  Future addImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } catch (error) {}
  }

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
              children: [
                Text(
                  "Your item",
                  textAlign: TextAlign.center,
                  style: kBigText,
                ),
                SizedBox(height: 20),
                IconButton(
                  iconSize: 60,
                  onPressed: () => addImage(),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        textField("title", titleController),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            maxLines: 10,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter some text";
                              }
                            },
                            controller: descriptionController,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.teal),
                              labelText: "description",
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                              ),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter some text";
                              }
                            },
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9 . ,]"),
                              ),
                            ],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.teal),
                              labelText: "price",
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                              ),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Button(
                  text: "add",
                  function: () {
                    if (formKey.currentState!.validate() && image != null) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
