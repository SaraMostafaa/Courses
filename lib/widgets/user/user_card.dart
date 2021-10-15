import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String? _userName;
  String? _avatar;
  Future<void> _getUserName() async {
    var user = await FirebaseAuth.instance.currentUser!;
    print(user.uid);
    var userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    setState(() {
      _userName = userData["username"];
      _avatar = userData["image_url"];
    });
  }

  // getUserData()async{
  //   await  FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(userCredential.user!.uid)
  //           .get("rrr")

  // FirebaseFirestore.instance.collection("courses").add({
  //   "title":,
  //   "syllabus":,
  //   "hours":,
  //   "start":,
  // })
  //}
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUserName(),
        builder: (context, userSnapshot) {
          return Container(
            width: 400,
            margin: EdgeInsets.all(
              10,
            ),
            child: Row(
              children: [
                if (_avatar != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(_avatar!),
                  ),
                SizedBox(width: 8),
                if (_userName != null)
                  Text(
                    'Welcome ${_userName} ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
