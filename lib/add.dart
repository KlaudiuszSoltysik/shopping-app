import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "components.dart";
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:rflutter_alert/rflutter_alert.dart";
import "package:provider/provider.dart";
import 'providers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Add extends StatefulWidget {
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Widget> images = [];
  List<XFile> imgs = [];

  Future addImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }
      imgs.add(image);

      setState(() {
        images.add(Image.file(
          File(image.path),
          width: 100,
        ));
      });
    } catch (error) {}
  }

  Future addItem(String title, String description, String price,
      List<XFile> imgs, String? user) async {
    final item = FirebaseFirestore.instance.collection("items").doc();
    List<String> imageNames = [];

    for (XFile image in imgs) {
      imageNames.add(image.name);
    }

    try {
      await item.set(
          Item(item.id, title, description, price, imageNames, user).toJson());
    } catch (exception) {}
  }

  Future uploadImage(String path, String name) async {
    try {
      await FirebaseStorage.instance.ref(name).putFile(File(path));
    } on FirebaseException catch (error) {
      await Alert(
              context: context,
              title: "SOMETHING WENT WRONG",
              desc: error.message)
          .show();
    }
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
              children: <Widget>[
                Text(
                  "Your item",
                  textAlign: TextAlign.center,
                  style: kBigText,
                ),
                SizedBox(height: 20),
                images.length < 3
                    ? IconButton(
                        iconSize: 60,
                        onPressed: () => addImage(),
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "You can add only 3 images",
                        textAlign: TextAlign.center,
                        style: kSmallText,
                      ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: images,
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
                button(
                  "add",
                  () async {
                    if (formKey.currentState!.validate() && images.isNotEmpty) {
                      for (XFile i in imgs) {
                        uploadImage(i.path, i.name);
                      }
                      addItem(
                          titleController.text,
                          descriptionController.text,
                          priceController.text,
                          imgs,
                          Provider.of<UserProvider>(context, listen: false)
                              .userEmail);

                      await Alert(context: context, title: "Added").show();
                      Navigator.of(context).pop();
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 240,
                  color: Colors.white.withOpacity(0.9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
