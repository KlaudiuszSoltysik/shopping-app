import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:shopping_app/providers.dart';
import "components.dart";
import "package:provider/provider.dart";

class Shop extends StatefulWidget {
  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<Widget> searchbar = [];
  final TextEditingController controller = TextEditingController();
  Stream<QuerySnapshot<Object?>>? stream =
      FirebaseFirestore.instance.collection("items").snapshots();

  @override
  void initState() {
    super.initState();
    controller.addListener(updateSearchbar);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateSearchbar() {
    setState(() {
      if (controller.text == "") {
        stream = FirebaseFirestore.instance.collection("items").snapshots();
      } else {
        stream = FirebaseFirestore.instance
            .collection("items")
            .where("title", isEqualTo: controller.text)
            .snapshots();
      }
    });
  }

  void addSearchbar() {
    setState(() {
      if (searchbar.isEmpty) {
        searchbar.add(
          Form(
            child: TextFormField(
              controller: controller,
              autofocus: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        );
      } else {
        stream = FirebaseFirestore.instance.collection("items").snapshots();
        controller.clear();
        searchbar.clear();
      }
    });
  }

  Future<String> downloadURL(String imageName) async {
    return await FirebaseStorage.instance.ref(imageName).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.amber,
        bottomNavigationBar: BottomAppBar(
          color: Colors.deepOrange[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  addSearchbar();
                },
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              if (Provider.of<UserProvider>(context, listen: false).userEmail !=
                  "")
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/add");
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              if (Provider.of<UserProvider>(context, listen: false).userEmail !=
                  "")
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/account");
                  },
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              if (Provider.of<UserProvider>(context, listen: false).userEmail !=
                  "")
                GestureDetector(
                  onTap: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .logout(context);
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data!.docs[index];
                                  return itemCard(
                                      doc["id"],
                                      doc["title"],
                                      doc["description"],
                                      doc["price"],
                                      doc["imageNames"],
                                      doc["user"],
                                      downloadURL(doc["imageNames"][0]),
                                      context);
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: searchbar,
              ),
            )
          ],
        ),
      ),
    );
  }
}
