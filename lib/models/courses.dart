import 'dart:convert';

class Courses {
  String? id;
  String? title;
  String? syllabus;
  double? amount;
  DateTime date = DateTime.now();
  DateTime startDate = DateTime.now();
  int? totalHours;

  Courses({
    this.id,
    this.title,
    required this.syllabus,
    required this.date,
    required this.totalHours,
    required this.startDate,
  });

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['title'] = title;
    m['syllabus'] = syllabus;
    m['date'] = json.encode(date.toIso8601String());
    m['totalHours'] = totalHours;
    m['startDate'] = json.encode(startDate.toIso8601String());

    return m;
  }

  fromJson() {
    return Courses(
        syllabus: syllabus,
        date: date,
        totalHours: totalHours,
        startDate: startDate);
  }
}
