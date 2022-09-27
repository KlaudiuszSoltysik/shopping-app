import 'package:flutter/material.dart';
import 'components.dart';

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
              Icon(
                Icons.add,
                color: Colors.white,
                size: 50,
              ),
              Icon(
                Icons.search,
                color: Colors.white,
                size: 50,
              ),
              Icon(
                Icons.logout,
                color: Colors.white,
                size: 50,
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
