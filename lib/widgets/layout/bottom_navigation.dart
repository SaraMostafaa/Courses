// ignore_for_file: prefer_const_constructors

import 'package:courses/screens/home.dart';
import 'package:courses/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  goto(BuildContext context, screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.blur_on, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.hotel, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.account_box, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
