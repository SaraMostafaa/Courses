// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/generated/l10n.dart';
import 'package:courses/models/courses.dart';
import 'package:courses/widgets/courses/courses_list.dart';
import 'package:courses/widgets/layout/nav_drawer.dart';
import 'package:dio/dio.dart';
import '../models/employees_response.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "../widgets/courses/new_course_form.dart";
import '../models/courses_list.dart';
import '../models/employee.dart';
import "../widgets/user/user_card.dart";

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
  List<dynamic> employees = [];

  bool isCourses = false;
}

class _HomeState extends State<Home> {
  final LocalStorage storage = new LocalStorage('coursesList');
  AllCourses courses = new AllCourses();
  List<Courses> courseList = [];
  void addNewCourse(
      String title, int totalHours, String syllabus, double amount) {
    final newCourse = Courses(
        id: DateTime.now().toString(),
        syllabus: syllabus,
        title: title,
        amount: amount,
        startDate: DateTime.now(),
        totalHours: totalHours);
    setState(() {
      courses.items.add(newCourse);
    });

    storage.setItem('coursesList', courses.toJSONEncodable());

    Navigator.of(context).pop();
  }

  void showAddCourseBottomSheeet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewCourse(addNewCourse),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  fetchProducts() async {
    final response = FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<Courses> temp = [];
      querySnapshot.docs.forEach((doc) {
        temp.add(Courses(
            title: doc["title"],
            amount: double.parse(doc["amount"].toString()),
            startDate: DateTime.now(),
            syllabus: doc["syllabus"],
            totalHours: int.parse(doc["hours"].toString()),
            id: "userId"));
      });
      setState(() {
        courseList = temp;
      });
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(S.of(context).sorry),
      content: Text(S.of(context).msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, userSnapshot) {
          return Directionality(
              child: Scaffold(
                drawer: NavDrawer(),
                appBar: AppBar(
                  title: Text(delegate.pageTitle),
                  actions: [
                    DropdownButton(
                      icon: Icon(Icons.more_vert,
                          color: Theme.of(context).primaryIconTheme.color),
                      items: [
                        DropdownMenuItem(
                          child: Container(
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                Text("🇦🇪"),
                                SizedBox(width: 8),
                                Text("العربية")
                              ],
                            ),
                          ),
                          value: "ar",
                        ),
                        DropdownMenuItem(
                          child: Container(
                              child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: <Widget>[
                                Text("🇺🇸"),
                                SizedBox(width: 8),
                                Text("English")
                              ])),
                          value: "en",
                        ),
                        DropdownMenuItem(
                          child: Container(
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                Icon(
                                  Icons.exit_to_app,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 8),
                                Text(S.of(context).logout)
                              ],
                            ),
                          ),
                          value: "logout",
                        ),
                      ],
                      onChanged: (itemIdentifier) {
                        if (itemIdentifier == "logout") {
                          FirebaseAuth.instance.signOut();
                        } else if (itemIdentifier == "ar") {
                          setState(() {
                            S.load(Locale("ar"));
                            S.isRTL = false;
                          });
                        } else if (itemIdentifier == "en") {
                          setState(() {
                            S.load(Locale("en"));
                            S.isRTL = false;
                          });
                        }
                      },
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserCard(),
                      CoursesList(courseList),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                      onPressed: () => showAddCourseBottomSheeet(context),
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ),
              ),
              textDirection:
                  S.isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr);
        },
      ),
    );
  }
}
