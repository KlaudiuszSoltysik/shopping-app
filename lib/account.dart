import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:shopping_app/providers.dart';
import "components.dart";
import "package:provider/provider.dart";

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Future<String> downloadURL(String imageName) async {
    return await FirebaseStorage.instance.ref(imageName).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("items")
                            .where("user",
                                isEqualTo: Provider.of<UserProvider>(context,
                                        listen: false)
                                    .userEmail)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data!.docs[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      itemCard(
                                          doc["id"],
                                          doc["title"],
                                          doc["description"],
                                          doc["price"],
                                          doc["imageNames"],
                                          doc["user"],
                                          downloadURL(doc["imageNames"][0]),
                                          context),
                                      button("messages", () {
                                        Navigator.pushNamed(context, "/message",
                                            arguments: Item(
                                              doc["id"],
                                              doc["title"],
                                              doc["description"],
                                              doc["price"],
                                              doc["imageNames"],
                                              doc["user"],
                                            ));
                                      }),
                                    ],
                                  );
                                });
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
