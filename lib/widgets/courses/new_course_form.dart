// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/generated/l10n.dart';
import 'package:courses/widgets/auth/upload_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class NewCourse extends StatefulWidget {
  final Function addNewCourse;

  NewCourse(this.addNewCourse);

  @override
  State<NewCourse> createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  UserCredential? userCredential;
  DateTime startDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");

  final titleController = TextEditingController();
  final syllabusController = TextEditingController();
  final totalHoursController = TextEditingController();
  final amountController = TextEditingController();
  final startDateController = TextEditingController();
  final descriptionController = TextEditingController();
  String? _courseImageURL =
      "https://images.assetsdelivery.com/compings_v2/pavelstasevich/pavelstasevich1811/pavelstasevich181101028.jpg";

  void pickedImage(File image) async {
    var user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseStorage.instance
        .ref()
        .child("course_image")
        .child(user.uid + DateTime.now().toString() + '.jpg');
    await ref.putFile(image);

    final url = await ref.getDownloadURL();
    _courseImageURL = url;
  }

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
    widget.addNewCourse(enteredTitle, enteredTotalHours, enteredSyllbus,
        enteredAmount, enteredDescription, _courseImageURL, startDate);
    var user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance.collection("courses").add({
      "name": enteredTitle,
      "syllabus": enteredSyllbus,
      "totalHours": enteredTotalHours,
      "startDate": startDate,
      "amount": enteredAmount,
      "instructorId": user.uid,
      "id": user.uid + DateTime.now().toString(),
      "image": _courseImageURL,
      "description": enteredDescription,
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              UserImagePicker(pickedImage),
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
                            labelText: "Start Date" //label text of field
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
                                DateFormat('yyyy-MM-dd').format(pickedDate);
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
                    "Add Course",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
