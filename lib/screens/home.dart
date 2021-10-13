// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, unused_local_variable

import 'package:courses/generated/l10n.dart';
import 'package:courses/models/courses.dart';
import 'package:courses/widgets/courses/courses_list.dart';
import '../models/employees_response.dart';
import 'package:courses/widgets/employees/employees_list.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "../widgets/courses/new_course_form.dart";
import '../models/courses_list.dart';
import '../models/employee.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalStorage storage = new LocalStorage('coursesList');
  AllCourses courses = new AllCourses();
  List<Employee> employees = [];

  void addNewCourse(String title, int totalHours, String syllabus) {
    final newCourse = Courses(
        id: DateTime.now().toString(),
        syllabus: syllabus,
        title: title,
        date: DateTime.now(),
        startDate: DateTime.now(),
        totalHours: totalHours);
    setState(() {
      courses.items.add(newCourse);
    });

    storage.setItem('coursesList', courses.toJSONEncodable());

    Navigator.of(context).pop();
  }

  void showAddCourseBottomSheeet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewCourse(addNewCourse),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Employee> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  Future<List<Employee>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));

    final jsonBody = jsonDecode(response.body) as EmployeesResponse;

    print(jsonBody);

    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      print('Unable to fetch products from the REST API');
      throw Exception("cant");
    }
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return FutureBuilder(
      future: fetchProducts(),
      builder: (context, userSnapshot) {
        return Directionality(
            child: Scaffold(
              appBar: AppBar(
                title: Text(delegate.pageTitle),
                actions: [
                  DropdownButton(
                    icon: Icon(Icons.more_vert,
                        color: Theme.of(context).primaryIconTheme.color),
                    items: [
                      DropdownMenuItem(
                        child: Container(
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Icon(Icons.exit_to_app),
                              SizedBox(width: 8),
                              Text("Logout")
                            ],
                          ),
                        ),
                        value: "logout",
                      )
                    ],
                    onChanged: (itemIdentifier) {
                      if (itemIdentifier == "logout") {
                        FirebaseAuth.instance.signOut();
                      }
                    },
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          textColor: S.isRTL
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              S.load(Locale("ar"));
                              S.isRTL = true;
                            });
                          },
                          child: Text("العربية"),
                        ),
                        MaterialButton(
                          textColor: !S.isRTL
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              S.load(Locale("en"));
                              S.isRTL = false;
                            });
                          },
                          child: Text("English"),
                        ),
                      ],
                    )
                    // CoursesList(courses),
                    //EmployeesList(employees),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: null,
                child: IconButton(
                    onPressed: () => showAddCourseBottomSheeet(context),
                    icon: Icon(Icons.add)),
              ),
            ),
            textDirection:
                S.isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr);
      },
    );
  }
}
