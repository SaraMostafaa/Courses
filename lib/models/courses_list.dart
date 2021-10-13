import '../models/courses.dart';

class AllCourses {
  List<Courses> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }

  fromJson(Map<String, dynamic> json) {
    return items.map((item) {
      return item.fromJson();
    }).toList();
  }
}
