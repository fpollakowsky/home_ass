import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("text"),
        actions: <Widget>[
          Hero(
            tag: "imgSC",
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24.0,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.greenAccent,
                size: 24,
              ),
            ),
          )
        ],
      ),
      body:  Center(
          child: Text(
    'Online Store \nFor Everyone',
    style: TextStyle(fontSize: 24.0),
    textAlign: TextAlign.center,
    ),
    ));
  }
}
