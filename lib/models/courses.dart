import 'dart:convert';

class Courses {
  String? id;
  String? title;
  String? syllabus;
  double? amount;
  DateTime startDate = DateTime.now();
  int? totalHours;
  String? imageURl;
  String description = "";

  Courses({
    this.id,
    this.title,
    required this.syllabus,
    required this.amount,
    required this.totalHours,
    required this.startDate,
    this.imageURl,
    required this.description,
  });

  toJSONEncodable() {
    Map<String, dynamic> m = {};

    m['id'] = id;
    m['title'] = title;
    m['syllabus'] = syllabus;
    m['amount'] = amount;
    m['totalHours'] = totalHours;
    m['startDate'] = json.encode(startDate.toIso8601String());

    return m;
  }

  fromJson() {
    return Courses(
        syllabus: syllabus,
        amount: amount,
        totalHours: totalHours,
        startDate: startDate,
        description: description);
  }
}
