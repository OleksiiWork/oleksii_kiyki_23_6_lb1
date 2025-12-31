import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
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
  var _isLoading = false; //  Індикатор завантаження
  String? _error; 

 
  final String _baseUrl = 'https://students-2da32-default-rtdb.firebaseio.com/students.json';

  final List<Department> _departments = [
    const Department(id: 'd_finance', name: 'Finance', icon: Icons.attach_money, color: Colors.green),
    const Department(id: 'd_law', name: 'Law', icon: Icons.gavel, color: Colors.redAccent),
    const Department(id: 'd_it', name: 'IT', icon: Icons.computer, color: Colors.blue),
    const Department(id: 'd_medical', name: 'Medical', icon: Icons.medical_services, color: Colors.teal),
  ];

  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents(); 
  }

  Future<void> _loadStudents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode >= 400) {
        throw Exception('Failed to fetch data. Please try again later.');
      }

      if (response.body == 'null') {
        setState(() {
          _students = [];
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<Student> loadedStudents = [];

      listData.forEach((key, value) {
        loadedStudents.add(Student.fromJson(value, key));
      });

      setState(() {
        _students = loadedStudents;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! ${error.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _addStudent(Student student) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        body: json.encode(student.toJson()),
      );

      if (response.statusCode >= 400) {
        throw Exception('Could not save student.');
      }

      final newId = json.decode(response.body)['name'];

      setState(() {
        _students.add(student.copyWith(id: newId));
        _isLoading = false;
      });
    } catch (error) {
       setState(() {
        _error = 'Failed to add student';
        _isLoading = false;
      });
    }
  }

  Future<void> _removeStudentFromBackend(Student student) async {
    final url = Uri.parse(_baseUrl.replaceFirst('.json', '/${student.id}.json'));
    
    try {
      final response = await http.delete(url);

      if (response.statusCode >= 400) {

        setState(() {
          _students.add(student); 
        });
        throw Exception('Could not delete student.');
      }
    } catch (error) {
       setState(() {
         _students.add(student); 
         _error = 'Deletion failed.';
       });
    }
  }

  Future<void> _editStudent(Student student) async {
     setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(_baseUrl.replaceFirst('.json', '/${student.id}.json'));

    try {
      await http.patch(
        url,
        body: json.encode(student.toJson()),
      );

      setState(() {
        final index = _students.indexWhere((s) => s.id == student.id);
        if (index != -1) {
          _students[index] = student;
        }
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Update failed';
        _isLoading = false;
      });
    }
  }


  void _removeStudentLocal(Student student) {
    setState(() {
      _students.removeWhere((s) => s.id == student.id);
    });
  }


  void _insertStudentLocal(Student student, int index) {
    setState(() {
      if (index >= _students.length) {
        _students.add(student);
      } else {
        _students.insert(index, student);
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(onPressed: _loadStudents, child: const Text('Retry'))
            ],
          ),
        ),
      );
    }

    Widget activePage = DepartmentsScreen(departments: _departments, students: _students);
    String activePageTitle = 'Departments';

    if (_selectedPageIndex == 1) {
      activePage = StudentsScreen(
        students: _students,
        departments: _departments,
        isLoading: _isLoading, // Передаємо статус завантаження
        onRemoveStudentLocal: _removeStudentLocal,
        onRemoveStudentPermanent: _removeStudentFromBackend, 
        onInsertStudentLocal: _insertStudentLocal,
        onAddStudent: _addStudent,
        onEditStudent: _editStudent,
        onRefresh: _loadStudents, // Для pull-to-refresh
      );
      activePageTitle = 'Students';
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0057B8), Color(0xFFFFD700)],
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