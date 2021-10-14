// ignore_for_file: prefer_const_constructors

import 'package:courses/generated/l10n.dart';
import "package:flutter/material.dart";
import 'package:localstorage/localstorage.dart';

class NewCourse extends StatefulWidget {
  final Function addNewCourse;

  NewCourse(this.addNewCourse);

  @override
  State<NewCourse> createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  final titleController = TextEditingController();
  final syllabusController = TextEditingController();
  final totalHoursController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredTotalHours = int.parse(totalHoursController.text);
    final enteredSyllbus = syllabusController.text;
    if (enteredTitle.isEmpty || enteredTotalHours <= 0 || enteredTitle.isEmpty)
      return;
    widget.addNewCourse(enteredTitle, enteredTotalHours, enteredSyllbus);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: S.of(context).title),
                controller: titleController,
                onSubmitted: (_) => {submitData()},
              ),
              TextField(
                decoration: InputDecoration(labelText: S.of(context).syllabus),
                controller: syllabusController,
                onSubmitted: (_) => {submitData()},
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: S.of(context).totalHours),
                controller: totalHoursController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => {submitData()},
              ),
              FlatButton(
                  onPressed: submitData,
                  child: const Text(
                    "Add Course",
                    style: TextStyle(color: Colors.purple),
                  ))
            ],
          ),
        ));
  }
}
