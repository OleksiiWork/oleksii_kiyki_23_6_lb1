import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart'; 
import 'package:oleksii_kiyki_23_6_lb1/widgets/student_item.dart'; 

class StudentsScreen extends StatelessWidget {
  StudentsScreen({super.key});

  //список студентів 
  final List<Student> students = [
    const Student(
      firstName: 'Сара',
      lastName: 'Коннор',
      department: Department.law,
      grade: 95,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Олексій',
      lastName: 'Рест',
      department: Department.it,
      grade: 100,
      gender: Gender.male,
    ),
    const Student(
      firstName: 'Джек',
      lastName: 'Деніел',
      department: Department.finance,
      grade: 90,
      gender: Gender.male,
    ),
    const Student(
      firstName: 'Гаррі',
      lastName: 'Поттер',
      department: Department.medical,
      grade: 80,
      gender: Gender.male,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //Scaffold віджет
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'), //Заголовок 
      ),
      //cтворення списку
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (ctx, index) {
          return StudentItem(student: students[index]);
        }
      ),
    );
  }
}