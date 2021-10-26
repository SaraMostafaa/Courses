// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/models/courses.dart';
import 'package:courses/screens/courses/edit.dart';
import 'package:courses/widgets/courses/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CourseListLitem extends StatefulWidget {
  String? courseName;
  String? courseAmount;
  DateTime? courseStartDate;
  String? courseId;
  String? courseImageURL =
      "https://st2.depositphotos.com/1350793/8441/i/600/depositphotos_84416316-stock-photo-hand-pointing-to-online-course.jpg";
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
  Future<void> _showMyDialog(courseId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete  this item'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Are you sure you   want to delete this course?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
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

                FirebaseFirestore.instance
                    .collection('courses')
                    .doc(courseId)
                    .delete()
                    .then((value) => print(courseId))
                    .catchError(
                        (error) => print("Failed to delete user: $error"));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteCourse(courseId) async {
    var answer = await _showMyDialog(courseId);
  }

  // goToEditPage() {
  //   var user = FirebaseAuth.instance.currentUser!;

  //   Courses previouseCourse = Courses(
  //     syllabus: widget.syllabus,
  //     amount: double.parse(widget.courseAmount!),
  //     totalHours: int.parse(widget.courseTotalHours!),
  //     startDate: widget.courseStartDate!,
  //     description: widget.courseDescription!,
  //     id: widget.courseId,
  //     imageURl: widget.courseImageURL,
  //     title: widget.courseName,
  //     instructorId: user.uid,
  //   );

  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               EditCourse(previouseCourse)));
  // }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: GestureDetector(
        onTap: () => {
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
                      description: widget.courseDescription!))))
        },
        child: Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image(
                      height: 100,
                      image: NetworkImage(widget.courseImageURL!),
                      fit: BoxFit.fill,
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.courseName!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('cost: \$ ${widget.courseAmount!}',
                          style: TextStyle(color: Colors.white)),
                      Text(
                          'start date: ${DateFormat("yyyy-MM-dd").format(
                            widget.courseStartDate!,
                          )}',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  flex: 2,
                ),
                Expanded(
                    child: Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 30.0))
              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(95, 158, 160, 1.0),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        // IconSlideAction(
        //   caption: 'Edit',
        //   color: Colors.black45,
        //   icon: Icons.more_horiz,
        //   onTap: () => {goToEditPage()},
        // ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {deleteCourse(widget.courseId)},
        ),
      ],
    );
  }
}
