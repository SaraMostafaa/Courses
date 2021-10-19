// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class CourseListLitem extends StatefulWidget {
  String? courseName;
  String? courseAmount;
  String? courseStartDate;
  String? courseId;
  String? courseImageURL;
  CourseListLitem(
    this.courseName,
    this.courseAmount,
    this.courseId,
    this.courseImageURL,
    this.courseStartDate,
  );
  @override
  _CourseListLitemState createState() => _CourseListLitemState();
}

class _CourseListLitemState extends State<CourseListLitem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
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
                    Text('start date: ${widget.courseStartDate!}',
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0)),
      ),
    );
  }
}
