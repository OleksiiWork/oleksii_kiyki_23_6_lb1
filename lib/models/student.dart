import 'package:flutter/material.dart';

//спеціальність
enum Department {
  finance,
  law,
  it,
  medical,
}

//стать
enum Gender {
  male,
  female,
}

//зіставлення іконок зі спеціальностями 
const departmentIcons = {
  Department.it: Icons.computer,
  Department.finance: Icons.attach_money,
  Department.law: Icons.gavel,
  Department.medical: Icons.medical_services,
};

// Клас студента 
class Student {
  const Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });

  final String firstName;
  final String lastName;
  final Department department;
  final int grade;
  final Gender gender;
}