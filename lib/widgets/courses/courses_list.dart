// ignore_for_file: use_key_in_widget_constructors, file_names

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
            ? Column(
                children: const <Widget>[
                  Text("no courses"),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            ' \$ ${courses[index].amount.toString()} ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.purple,
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          )),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              courses[index].title.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${courses[index].totalHours.toString()} hour',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: courses.length,
              ));
  }
}
