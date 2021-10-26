// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/generated/l10n.dart';
import 'package:courses/models/courses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditCourse extends StatefulWidget {
  Courses course;
  final Function updateDetails;

  EditCourse(this.course, this.updateDetails);

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  UserCredential? userCredential;
  DateTime startDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");

  final titleController = TextEditingController();
  final syllabusController = TextEditingController();
  final totalHoursController = TextEditingController();
  final amountController = TextEditingController();
  final startDateController = TextEditingController();
  final descriptionController = TextEditingController();
  String? _courseImage =
      "https://images.assetsdelivery.com/compings_v2/pavelstasevich/pavelstasevich1811/pavelstasevich181101028.jpg";

  void submitData() async {
    final enteredTitle = titleController.text;
    final enteredTotalHours = int.parse(totalHoursController.text);
    final enteredSyllbus = syllabusController.text;
    final enteredDescription = descriptionController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty ||
        enteredTotalHours <= 0 ||
        enteredTitle.isEmpty ||
        enteredAmount <= 0) return;
    // widget.editCourse(enteredTitle, enteredTotalHours, enteredSyllbus,
    //     enteredAmount, enteredDescription, _courseImage, startDate);
    print(widget.course.id);
    var user = FirebaseAuth.instance.currentUser!;

    return FirebaseFirestore.instance
        .collection('courses')
        .where("id", isEqualTo: widget.course.id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("courses")
            .doc(element.id)
            .update({
              "name": enteredTitle,
              "syllabus": enteredSyllbus,
              "totalHours": enteredTotalHours,
              "startDate": startDate,
              "amount": enteredAmount,
              "instructorId": user.uid,
              "id": user.uid + DateTime.now().toString(),
              "image":
                  "https://st2.depositphotos.com/1350793/8441/i/600/depositphotos_84416316-stock-photo-hand-pointing-to-online-course.jpg",
              "description": enteredDescription,
            })
            .then((value) => {
                  widget.updateDetails(Courses(
                      syllabus: enteredSyllbus,
                      amount: enteredAmount,
                      totalHours: enteredTotalHours,
                      startDate: startDate,
                      description: enteredDescription,
                      title: enteredTitle)),
                  Navigator.of(context).pop()
                })
            .catchError((error) => print("Failed to delete user: $error"));
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  setInputs() {
    titleController.text = widget.course.title!;
    totalHoursController.text = widget.course.totalHours.toString();
    syllabusController.text = widget.course.syllabus!;
    descriptionController.text = widget.course.description;
    amountController.text = widget.course.amount.toString();
    startDateController.text =
        DateFormat('yyyy-MM-dd').format(widget.course.startDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.course.title!),
          backgroundColor: Color.fromRGBO(95, 158, 160, 1.0),
        ),
        resizeToAvoidBottomInset: true,
        body: FutureBuilder(
            future: setInputs(),
            builder: (context, userSnapshot) {
              return Container(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextField(
                          decoration:
                              InputDecoration(labelText: S.of(context).title),
                          controller: titleController,
                          onSubmitted: (_) => {submitData()},
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: S.of(context).syllabus),
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
                          decoration: InputDecoration(
                              labelText: S.of(context).totalHours),
                          controller: totalHoursController,
                          keyboardType: TextInputType.number,
                          onSubmitted: (_) => {submitData()},
                        ),
                        Column(children: <Widget>[
                          Container(
                              // padding: EdgeInsets.all(15),
                              height: 100,
                              child: Center(
                                child: TextField(
                                  controller:
                                      startDateController, //editing controller of this TextField
                                  decoration: InputDecoration(
                                      //icon of text field
                                      labelText:
                                          "Start Date" //label text of field
                                      ),
                                  readOnly:
                                      true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      setState(() {
                                        startDate = pickedDate;
                                      }); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        startDateController.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              )),
                        ]),
                        TextField(
                          decoration: InputDecoration(labelText: "Description"),
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          onSubmitted: (_) => {submitData()},
                        ),
                        FlatButton(
                            onPressed: submitData,
                            child: Text(
                              "Edit Course",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
