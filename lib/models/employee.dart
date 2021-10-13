class Employee {
  String? id;
  String? employee_name;
  int? employee_age;
  String? profile_image;
  int? employee_salary;

  Employee({
    this.id,
    this.employee_name,
    required this.employee_age,
    required this.profile_image,
    required this.employee_salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employee_name: json["employee_name"],
        employee_age: json["employee_age"],
        profile_image: json["profile_image"],
        employee_salary: json["employee_salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employee_name,
        "employee_age": employee_age,
        "profile_image": profile_image,
        "employee_salary": employee_salary,
      };
}
