import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/widgets/new_student.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart'; 
import 'package:oleksii_kiyki_23_6_lb1/widgets/student_item.dart'; 

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() {
    return _StudentsScreenState();
  }
}

  //список студентів 
  class _StudentsScreenState extends State<StudentsScreen> {
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

//модальне вікно
  void _openAddStudentModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewStudent(onSaveStudent: _addStudent),
    );
  }

  //додавання студента
  void _addStudent(Student student) {
    setState(() {
      students.add(student);
    });
  }

  //видалення студента
  void _removeStudent(Student student) {
    final studentIndex = students.indexOf(student); //індекс
    
    setState(() {
      students.remove(student);
    });

    //очищуємо SnackBar
    ScaffoldMessenger.of(context).clearSnackBars(); 
    
    //SnackBar з кнопкою "Undo"
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Студента видалено.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              students.insert(studentIndex, student);
            });
          },
        ),
      ),
    );
  }
  
  //модальне вікно в режимі редагування
  void _openEditStudentModal(Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewStudent(
        onSaveStudent: (updatedStudent) {
          _updateStudent(student, updatedStudent);
        },
        existingStudent: student,
      ),
    );
  }

  //оновлення даних студента
  void _updateStudent(Student oldStudent, Student newStudent) {
    final studentIndex = students.indexOf(oldStudent);
    setState(() {
      students[studentIndex] = newStudent;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        //кнопка "+"
        actions: [
          IconButton(
            onPressed: _openAddStudentModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (ctx, index) {
          final student = students[index];
          //віджет свайпу
          return Dismissible(
            key: ValueKey(student), 
            background: Container(
              color: Theme.of(context).colorScheme.error.withAlpha(191),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            direction: DismissDirection.endToStart, //свайп в одну сторону
            onDismissed: (direction) {
              _removeStudent(student);
            },
            //
            child: InkWell(
              onTap: () {
                _openEditStudentModal(student); // 
              },
              child: StudentItem(student: student),
            ),
          );
        },
      ),
    );
  }
}