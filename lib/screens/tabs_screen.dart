import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/department.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart';
import 'package:oleksii_kiyki_23_6_lb1/screens/departments_screen.dart';
import 'package:oleksii_kiyki_23_6_lb1/screens/students_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;


  final List<Department> _departments = [
    const Department(id: 'd_finance', name: 'Finance', icon: Icons.attach_money, color: Colors.green),
    const Department(id: 'd_law', name: 'Law', icon: Icons.gavel, color: Colors.redAccent),
    const Department(id: 'd_it', name: 'IT', icon: Icons.computer, color: Colors.blue),
    const Department(id: 'd_medical', name: 'Medical', icon: Icons.medical_services, color: Colors.teal),
  ];

  final List<Student> _students = [
    Student(firstName: 'Sarah', lastName: 'Konnor', departmentId: 'd_law', grade: 95, gender: Gender.female),
    Student(firstName: 'Oleksii', lastName: 'Rest', departmentId: 'd_it', grade: 100, gender: Gender.male),
    Student(firstName: 'Jack', lastName: 'Daniel', departmentId: 'd_finance', grade: 90, gender: Gender.male),
    Student(firstName: 'Garry', lastName: 'Potter', departmentId: 'd_medical', grade: 80, gender: Gender.male),
  ];

  void _addStudent(Student student) { setState(() { _students.add(student); }); }
  void _removeStudent(Student student) { setState(() { _students.removeWhere((s) => s.id == student.id); }); }
  void _insertStudent(Student student, int index) { setState(() { if (index >= _students.length) { _students.add(student); } else { _students.insert(index, student); } }); }
  void _editStudent(Student student) { setState(() { final index = _students.indexWhere((s) => s.id == student.id); if (index != -1) { _students[index] = student; } }); }
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Widget activePage = DepartmentsScreen(departments: _departments, students: _students);
    String activePageTitle = 'Departments';
    if (_selectedPageIndex == 1) {
      activePage = StudentsScreen(
        students: _students,
        departments: _departments,
        onRemoveStudent: _removeStudent,
        onInsertStudent: _insertStudent,
        onAddStudent: _addStudent,
        onEditStudent: _editStudent,
      );
      activePageTitle = 'Students';
    }
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0057B8), 
            Color(0xFFFFD700), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        appBar: _selectedPageIndex == 0 ? AppBar(title: Text(activePageTitle)) : null,
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Departments'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Students'),
          ],
        ),
      ),
    );
  }
}