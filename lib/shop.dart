// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:shopping_app/providers.dart';
import "components.dart";
import "package:provider/provider.dart";

class Shop extends StatefulWidget {
  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
                          null
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
                onTap: () {},
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
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
