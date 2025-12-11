
import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/department.dart'; 
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart';   
import 'package:oleksii_kiyki_23_6_lb1/widgets/department_item.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({
    super.key,
    required this.departments,
    required this.students,
  });

  final List<Department> departments;
  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2.3, 
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final department in departments)
          DepartmentItem(
            department: department,
            studentCount: students.where((s) => s.departmentId == department.id).length,
          )
      ],
    );
  }
}