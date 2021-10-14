import 'package:courses/models/employee.dart';

class EmployeesResponse {
  String? status;
  String? message;
  List<Employee>? data = [];

  EmployeesResponse({this.status, this.message, this.data});

  fromJson(Map<String, dynamic> json) {
    return EmployeesResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
