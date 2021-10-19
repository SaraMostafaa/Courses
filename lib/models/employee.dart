// ignore_for_file: non_constant_identifier_names

class Employee {
  String? id;
  String? employee_name;
  int? employee_age;
  String? profile_image;
  int? employee_salary;

  Employee(
    this.id,
    this.employee_name,
    this.employee_age,
    this.profile_image,
    this.employee_salary,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employee_name,
        "employee_age": employee_age,
        "profile_image": profile_image,
        "employee_salary": employee_salary,
      };
}
