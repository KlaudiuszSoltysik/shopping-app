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
                onTap: () {},
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false).userEmail !=
                          ""
                      ? Navigator.pushNamed(context, "/add")
                      : Navigator.pushNamed(context, "/log-in");
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false).userEmail !=
                          ""
                      ? Navigator.pushNamed(context, "/shop")
                      : Navigator.popAndPushNamed(context, "/log-in");
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("items")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
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
    );
  }
}
