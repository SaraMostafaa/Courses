// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final amountController = TextEditingController();

  void submitData() async {
    final enteredTitle = titleController.text;
    final enteredTotalHours = int.parse(totalHoursController.text);
    final enteredSyllbus = syllabusController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty ||
        enteredTotalHours <= 0 ||
        enteredTitle.isEmpty ||
        enteredAmount <= 0) return;
    widget.addNewCourse(
        enteredTitle, enteredTotalHours, enteredSyllbus, enteredAmount);
    var user = await FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance.collection("courses").add({
      "name": enteredTitle,
      "syllabus": enteredSyllbus,
      "totalHours": enteredTotalHours,
      "startDate": DateTime.now(),
      "amount": enteredAmount,
      "instructorId": user.uid
    });
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
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
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
