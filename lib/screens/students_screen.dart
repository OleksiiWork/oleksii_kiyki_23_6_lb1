import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/department.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart';
import 'package:oleksii_kiyki_23_6_lb1/widgets/student_item.dart';
import 'package:oleksii_kiyki_23_6_lb1/widgets/new_student.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({
    super.key,
    required this.students,
    required this.departments,
    required this.isLoading, 
    required this.onRemoveStudentLocal,
    required this.onRemoveStudentPermanent,
    required this.onInsertStudentLocal,
    required this.onAddStudent,
    required this.onEditStudent,
    required this.onRefresh,
  });

  final List<Student> students;
  final List<Department> departments;
  final bool isLoading;
  
  final Function(Student) onRemoveStudentLocal;
  final Function(Student) onRemoveStudentPermanent;
  final Function(Student, int) onInsertStudentLocal;
  
  final Function(Student) onAddStudent;
  final Function(Student) onEditStudent;
  final Future<void> Function() onRefresh;

  void _openAddStudentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0057B8),
      builder: (ctx) => NewStudent(departments: departments, onSaveStudent: onAddStudent),
    );
  }

  void _openEditStudentModal(BuildContext context, Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0057B8),
      builder: (ctx) => NewStudent(departments: departments, existingStudent: student, onSaveStudent: onEditStudent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(onPressed: () => _openAddStudentModal(context), icon: const Icon(Icons.add)),
        ],
      ),
      
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : RefreshIndicator( 
              onRefresh: onRefresh,
              child: students.isEmpty
                  ? const Center(child: Text('No students yet.', style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (ctx, index) {
                        final student = students[index];
                        final department = departments.firstWhere(
                          (d) => d.id == student.departmentId,
                          orElse: () => departments.first,
                        );

                        return Dismissible(
                          key: ValueKey(student.id),
                          background: Container(
                            color: Theme.of(context).colorScheme.error.withValues(alpha: 0.8),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete, color: Colors.white, size: 30),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            
                            onRemoveStudentLocal(student);

                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 3),
                                content: const Text('Student deleted.'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    
                                    onInsertStudentLocal(student, index);
                                  },
                                ),
                              ),
                            )
                          
                            .closed.then((reason) {
                           
                              if (reason != SnackBarClosedReason.action) {
                                onRemoveStudentPermanent(student);
                              }
                            });
                          },
                          child: InkWell(
                            onTap: () => _openEditStudentModal(context, student),
                            child: StudentItem(
                              student: student,
                              departmentIcon: department.icon,
                              departmentColor: department.color,
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}