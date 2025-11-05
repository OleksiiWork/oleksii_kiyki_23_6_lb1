import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/widgets/students.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //дебаг-банер
      debugShowCheckedModeBanner: false,
      title: 'List of students',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentsScreen(),
    );
  }
}
