import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart'; 

class StudentItem extends StatelessWidget {
  const StudentItem({
    super.key,
    required this.student,
    required this.departmentIcon,
    required this.departmentColor,
  });

  final Student student;
  final IconData departmentIcon;
  final Color departmentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: departmentColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${student.firstName} ${student.lastName}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Icon(departmentIcon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              student.grade.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}