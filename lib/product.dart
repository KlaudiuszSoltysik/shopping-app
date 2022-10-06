import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "components.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'providers.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<int> createList(images) {
    List<int> list = [];
    int number = 0;

    for (String i in images) {
      list.add(number);
      number++;
    }

    return list;
  }

  Future<String> downloadURL(String imageName) async {
    return await FirebaseStorage.instance.ref(imageName).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Item;

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
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    item.title,
                    style: kBigText,
                  ),
                  SizedBox(height: 20),
                  CarouselSlider(
                    options: CarouselOptions(height: 400.0),
                    items: createList(item.imageNames).map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: FutureBuilder(
                                future: downloadURL(item.imageNames[i]),
                                builder:
                                    (context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    // return Image.network(
                                    //   snapshot.data.toString(),
                                    //   height: 200,
                                    //   fit: BoxFit.cover,
                                    return CachedNetworkImage(
                                      imageUrl: snapshot.data.toString(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      height: 200,
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${item.price} PLN",
                    style: kMediumText,
                  ),
                  SizedBox(height: 20),
                  Text(
                    item.description,
                    style: kSmallText,
                  ),
                  SizedBox(height: 20),
                  if ((Provider.of<UserProvider>(context, listen: false)
                              .userEmail !=
                          item.user) &&
                      (Provider.of<UserProvider>(context, listen: false)
                              .userEmail !=
                          ""))
                    button("message", () {
                      Navigator.pushNamed(context, "/message",
                          arguments: Item(item.id, item.title, item.description,
                              item.price, item.imageNames, item.user));
                    }),
                  if (Provider.of<UserProvider>(context, listen: false)
                          .userEmail ==
                      item.user)
                    button("delete", () {
                      FirebaseFirestore.instance
                          .collection("items")
                          .doc(item.id)
                          .delete();
                      Navigator.pop(context);
                    }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
