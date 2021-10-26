// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors

import 'package:courses/widgets/courses/list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/courses_list.dart';
import "../../models/courses.dart";

class CoursesList extends StatelessWidget {
  List<Courses> courses = [];

  CoursesList(this.courses);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 460,
        child: courses.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "No Courses Added",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ))
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return CourseListLitem(
                      courses[index].title.toString(),
                      courses[index].amount.toString(),
                      courses[index].id.toString(),
                      courses[index].imageURl.toString(),
                      courses[index].startDate,
                      courses[index].totalHours.toString(),
                      courses[index].syllabus.toString(),
                      courses[index].description);
                },
                itemCount: courses.length,
                itemExtent: 120,
              ));
  }
}
