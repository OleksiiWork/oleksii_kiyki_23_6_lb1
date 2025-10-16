import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart'; 

class StudentItem extends StatelessWidget {
  const StudentItem({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    //кольор статі 
    final cardColor = student.gender == Gender.male ? Colors.blue : Colors.pinkAccent;

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            //ім'я та прізвище студента
            Expanded(
              child: Text(
                '${student.firstName} ${student.lastName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            //спеціальність
            Icon(
              departmentIcons[student.department],
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            //оцінка 
            Text(
              student.grade.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}