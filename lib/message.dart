import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:shopping_app/providers.dart';
import "components.dart";
import "package:provider/provider.dart";

class Message extends StatefulWidget {
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController controller = TextEditingController();

  Future sendMessage(String itemId, String messageText, String? user) async {
    final message =
        FirebaseFirestore.instance.collection("message${itemId}").doc();

    try {
      await message.set(MessageClass(messageText, user).toJson());
    } catch (exception) {}
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as Item;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("message${item.id}")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot doc =
                                        snapshot.data!.docs[index];
                                    return messageBubble(doc["message"]);
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        // onFieldSubmitted: () async {
                        //   if (controller.text != "") {
                        //     sendMessage(
                        //         item.id,
                        //         controller.text,
                        //         Provider.of<UserProvider>(context,
                        //                 listen: false)
                        //             .userEmail);
                        //     controller.clear();
                        //   }
                        // },
                        controller: controller,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (controller.text != "") {
                          sendMessage(
                              item.id,
                              controller.text,
                              Provider.of<UserProvider>(context, listen: false)
                                  .userEmail);
                          controller.clear();
                        }
                      },
                      child: Text(
                        'send',
                        style: kSmallText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
