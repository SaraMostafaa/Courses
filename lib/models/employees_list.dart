import 'package:courses/models/employee.dart';

import '../models/employee.dart';

class AllCourses {
  List<Employee> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJson();
    }).toList();
  }
}
