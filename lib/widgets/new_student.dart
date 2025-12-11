
import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/department.dart'; 
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart';    

class NewStudent extends StatefulWidget {
  const NewStudent({
    super.key,
    required this.departments,
    required this.onSaveStudent,
    this.existingStudent,
  });

  final List<Department> departments;
  final void Function(Student) onSaveStudent;
  final Student? existingStudent;

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _gradeController = TextEditingController();

  String? _selectedDepartmentId;
  Gender _selectedGender = Gender.male;

  @override
  void initState() {
    super.initState();
    if (widget.existingStudent != null) {
      _firstNameController.text = widget.existingStudent!.firstName;
      _lastNameController.text = widget.existingStudent!.lastName;
      _gradeController.text = widget.existingStudent!.grade.toString();
      _selectedDepartmentId = widget.existingStudent!.departmentId;
      _selectedGender = widget.existingStudent!.gender;
    } else if (widget.departments.isNotEmpty) {
      _selectedDepartmentId = widget.departments.first.id;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _submitData() {
    final enteredGrade = int.tryParse(_gradeController.text);

    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty ||
        enteredGrade == null ||
        _selectedDepartmentId == null) {
      return;
    }

    if (widget.existingStudent != null) {
      widget.onSaveStudent(widget.existingStudent!.copyWith(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        departmentId: _selectedDepartmentId,
        grade: enteredGrade,
        gender: _selectedGender,
      ));
    } else {
      widget.onSaveStudent(Student(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        departmentId: _selectedDepartmentId!,
        grade: enteredGrade,
        gender: _selectedGender,
      ));
    }
    Navigator.pop(context);
  }

  // Стиль для текстових полів
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellowAccent)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        children: [
          TextField(controller: _firstNameController, style: const TextStyle(color: Colors.white), decoration: _inputDecoration('First Name')),
          TextField(controller: _lastNameController, style: const TextStyle(color: Colors.white), decoration: _inputDecoration('Last Name')),
          TextField(controller: _gradeController, style: const TextStyle(color: Colors.white), keyboardType: TextInputType.number, decoration: _inputDecoration('Grade')),
          
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            initialValue: _selectedDepartmentId, 
            dropdownColor: const Color(0xFF004494), 
            style: const TextStyle(color: Colors.white),
            items: widget.departments.map((dept) => DropdownMenuItem(
              value: dept.id,
              child: Row(children: [Icon(dept.icon, color: dept.color), const SizedBox(width: 8), Text(dept.name)]),
            )).toList(),
            onChanged: (value) => setState(() => _selectedDepartmentId = value),
            decoration: _inputDecoration('Department'),
          ),
          
          const SizedBox(height: 16),
          
          DropdownButtonFormField<Gender>(
            initialValue: _selectedGender, 
            dropdownColor: const Color(0xFF004494),
            style: const TextStyle(color: Colors.white),
            items: Gender.values.map((g) => DropdownMenuItem(
              value: g, 
              child: Text(g.name.toUpperCase()),
            )).toList(),
            onChanged: (val) => setState(() => _selectedGender = val!),
            decoration: _inputDecoration('Gender'),
          ),
          
          const SizedBox(height: 24),
          
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellowAccent,
              foregroundColor: Colors.blue[900],
            ),
            onPressed: _submitData, 
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}