// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/models/courses.dart';
import 'package:courses/widgets/courses/details.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CourseListLitem extends StatefulWidget {
  String? courseName;
  String? courseAmount;
  DateTime? courseStartDate;
  String? courseId;
  String? courseImageURL;
  String? courseTotalHours;
  String? syllabus;
  String? courseDescription;
  CourseListLitem(
    this.courseName,
    this.courseAmount,
    this.courseId,
    this.courseImageURL,
    this.courseStartDate,
    this.courseTotalHours,
    this.syllabus,
    this.courseDescription,
  );
  @override
  _CourseListLitemState createState() => _CourseListLitemState();
}

class _CourseListLitemState extends State<CourseListLitem> {
  Future<void> deleteUser(courseId) {
    FirebaseFirestore.instance
        .collection("courses")
        .where("id", isEqualTo: courseId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("courses")
            .doc(element.id)
            .delete()
            .then((value) {
          print("Success!");
        });
      });
    });

    return FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .delete()
        .then((value) => print(courseId))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(95, 158, 160, 1.0)),
          child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(Courses(
                            amount: double.parse(widget.courseAmount!),
                            startDate: widget.courseStartDate!,
                            totalHours: int.parse(widget.courseTotalHours!),
                            id: widget.courseId,
                            title: widget.courseName,
                            imageURl: widget.courseImageURL,
                            syllabus: widget.syllabus,
                            description: widget.courseDescription!))));
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: Icon(Icons.autorenew, color: Colors.white),
              ),
              title: Text(
                widget.courseName!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

              subtitle: Column(
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Text('cost: \$ ${widget.courseAmount!}',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Text(
                          'start date: ${DateFormat("yyyy-MM-dd").format(
                            widget.courseStartDate!,
                          )}',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0)),
        ),
      ),
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Edit',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => {},
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {deleteUser(widget.courseId)},
        ),
      ],
    );
  }
}
