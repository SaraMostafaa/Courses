// ignore_for_file: use_key_in_widget_constructors, file_names

import '../../models/employee.dart';
import 'package:flutter/material.dart';

class EmployeesList extends StatelessWidget {
  List employees = [];
  EmployeesList(this.employees);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 460,
        child: employees.isEmpty
            ? Column(
                children: const <Widget>[
                  Text("no employees"),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            '\$ ${employees[index].employee_name} ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                              employees[index].employee_salary.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              employees[index].employee_age.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: employees.length,
              ));
  }
}
