// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:courses/generated/l10n.dart';

import '../../models/employee.dart';
import 'package:flutter/material.dart';

class EmployeesList extends StatefulWidget {
  List<Employee> employees = [];
  List<dynamic> recivedEmployees;
  EmployeesList(this.recivedEmployees);

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  fetchEmployees() async {
    print("here is the other side");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchEmployees(),
        builder: (context, userSnapshot) {
          return Container(
              height: 460,
              child: widget.recivedEmployees.isEmpty
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
                                width: 200,
                                child: Text(
                                  widget.recivedEmployees[index]
                                      ["employee_name"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                decoration: BoxDecoration(),
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${S.of(context).salary} \$ ${widget.recivedEmployees[index]["employee_salary"].toString()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  Text(
                                    '${S.of(context).age}  ${widget.recivedEmployees[index]["employee_age"].toString()}',
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
                      itemCount: widget.recivedEmployees.length,
                    ));
        });
  }
}
