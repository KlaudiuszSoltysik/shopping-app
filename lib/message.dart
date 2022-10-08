import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:shopping_app/providers.dart';
import "components.dart";
import "package:provider/provider.dart";

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController controller = TextEditingController();
  int lastMessage = 0;

  Future sendMessage(String itemId, String messageText, String? user) async {
    lastMessage++;

    final message =
        FirebaseFirestore.instance.collection("message$itemId").doc();

    try {
      await message.set(MessageClass(messageText, user, lastMessage).toJson());
    } catch (exception) {}
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as Item;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrangeAccent, Colors.amber],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("message${item.id}")
                          .orderBy("messageCount", descending: false)
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
                                lastMessage = doc["messageCount"];
                                return messageBubble(
                                    doc["message"],
                                    Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .userEmail ==
                                            doc["user"]
                                        ? true
                                        : false);
                              });
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ),
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
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
                                  .userEmail,
                            );
                            controller.clear();
                          }
                        },
                        child: const Text(
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
      ),
    );
  }
}
