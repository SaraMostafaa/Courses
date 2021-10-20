// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/generated/l10n.dart';
import 'package:courses/models/courses.dart';
import 'package:courses/widgets/courses/courses_list.dart';
import 'package:courses/widgets/layout/bottom_navigation.dart';
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
  void addNewCourse(String title, int totalHours, String syllabus,
      double amount, String description, String image, DateTime startDate) {
    final newCourse = Courses(
        id: DateTime.now().toString(),
        syllabus: syllabus,
        title: title,
        amount: amount,
        startDate: startDate,
        totalHours: totalHours,
        description: description,
        imageURl: image);
    setState(() {
      courses.items.add(newCourse);
    });

    storage.setItem('coursesList', courses.toJSONEncodable());

    Navigator.of(context).pop();
  }

  void showAddCourseBottomSheeet(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: NewCourse(addNewCourse),
            ),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  fetchProducts() async {
    var user = FirebaseAuth.instance.currentUser!;
    final response = FirebaseFirestore.instance
        .collection('courses')
        .where("instructorId", isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<Courses> temp = [];
      querySnapshot.docs.forEach((doc) {
        temp.add(
          Courses(
              title: doc["name"],
              amount: double.parse(doc["amount"].toString()),
              startDate: doc["startDate"].toDate(),
              syllabus: doc["syllabus"],
              totalHours: int.parse(doc["totalHours"].toString()),
              id: doc["id"],
              description: doc["description"],
              instructorId: doc["instructorId"]),
        );
      });
      setState(() {
        courseList = temp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, userSnapshot) {
          return Directionality(
              child: Scaffold(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                drawer: NavDrawer(),
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                  title: Text(delegate.pageTitle),
                ),
                //bottomSheet: BottomNavigation(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // UserCard(),
                      CoursesList(courseList),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
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
