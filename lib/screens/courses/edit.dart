// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/generated/l10n.dart';
import 'package:courses/models/courses.dart';
import 'package:courses/widgets/auth/upload_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class EditCourse extends StatefulWidget {
  Courses course;
  final Function updateDetails;

  EditCourse(this.course, this.updateDetails);

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  final _editCourseFormKey = GlobalKey<FormState>();

  UserCredential? userCredential;
  DateTime startDate = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");

  final titleController = TextEditingController();
  final syllabusController = TextEditingController();
  final totalHoursController = TextEditingController();
  final amountController = TextEditingController();
  final startDateController = TextEditingController();
  final descriptionController = TextEditingController();
  String? _courseImageURL = "";

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
    final isValid = _editCourseFormKey.currentState!.validate();
    print(isValid);
    FocusScope.of(context).unfocus();

    if (isValid) {
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
                "image": _courseImageURL == ""
                    ? widget.course.imageURl
                    : _courseImageURL,
                "description": enteredDescription,
              })
              .then((value) => {
                    widget.updateDetails(Courses(
                      syllabus: enteredSyllbus,
                      amount: enteredAmount,
                      totalHours: enteredTotalHours,
                      startDate: startDate,
                      description: enteredDescription,
                      title: enteredTitle,
                      imageURl: _courseImageURL == ""
                          ? widget.course.imageURl
                          : _courseImageURL,
                    )),
                    Navigator.of(context).pop()
                  })
              .catchError((error) => print("Failed to delete user: $error"));
        });
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

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
                    child: Form(
                      key: _editCourseFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          UserImagePicker(pickedImage, widget.course.imageURl!),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: S.of(context).courseFormTitle),
                            controller: titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).courseFormTitleValidation;
                              }
                              return null;
                            },
                            onSaved: (_) => {submitData()},
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S
                                    .of(context)
                                    .courseFormSyllabusValidation;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: S.of(context).courseFormSyllabus),
                            controller: syllabusController,
                            onSaved: (_) => {submitData()},
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).courseFormAmountValidation;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: S.of(context).courseFormAmount),
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            onSaved: (_) => {submitData()},
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S
                                    .of(context)
                                    .courseFormTotalHoursValidation;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: S.of(context).courseFormTotalHours),
                            controller: totalHoursController,
                            keyboardType: TextInputType.number,
                            onSaved: (_) => {submitData()},
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
                                        labelText: S
                                            .of(context)
                                            .courseFormStartDate //label text of field
                                        ),
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime
                                                  .now(), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        setState(() {
                                          startDate = pickedDate;
                                          startDateController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        }); //pickedDate output format => 2021-03-10 00:00:00.000

                                      } else {
                                        print(S
                                            .of(context)
                                            .courseFormStartDateValidation);
                                      }
                                    },
                                  ),
                                )),
                          ]),
                          TextField(
                            decoration: InputDecoration(
                                labelText: S.of(context).courseFormDescription),
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            onSubmitted: (_) => {submitData()},
                          ),
                          FlatButton(
                              onPressed: submitData,
                              child: Text(
                                S.of(context).courseFormEdit,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
