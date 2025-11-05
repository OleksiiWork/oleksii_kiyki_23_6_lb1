import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/student.dart'; 

class NewStudent extends StatefulWidget {
  const NewStudent({
    super.key,
    required this.onSaveStudent,
    this.existingStudent, //редактування віджету
  });

  final void Function(Student student) onSaveStudent;
  final Student? existingStudent; 

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  //контролери 
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _gradeController = TextEditingController();

  //збереження значень дропдаунів
  Department? _selectedDepartment = Department.it;
  Gender? _selectedGender = Gender.male;

  @override
  void initState() {
    super.initState();
    //заповнюємо поля існуючими даними при редагуванні
    if (widget.existingStudent != null) {
      _firstNameController.text = widget.existingStudent!.firstName;
      _lastNameController.text = widget.existingStudent!.lastName;
      _gradeController.text = widget.existingStudent!.grade.toString();
      _selectedDepartment = widget.existingStudent!.department;
      _selectedGender = widget.existingStudent!.gender;
    }
  }

  //очистка контролерів
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _submitData() {
    //валідація 
    final enteredGrade = int.tryParse(_gradeController.text);
    final gradeIsInvalid = enteredGrade == null || enteredGrade <= 0;

    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty ||
        gradeIsInvalid) {
      //помилка
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Некоректні дані'),
          content: const Text(
              'Будь ласка, перевірте правильність введених імені, прізвища та оцінки.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('ОК'),
            ),
          ],
        ),
      );
      return;
    }

    //збереження змін
    widget.onSaveStudent(
      Student(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        department: _selectedDepartment!,
        grade: enteredGrade,
        gender: _selectedGender!,
      ),
    );

    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //падінг для клавіатури
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: Column(
          children: [
            //заголовок 
            Text(
              widget.existingStudent == null ? 'Додати студента' : 'Редагувати студента',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            
            
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'Ім\'я'),
            ),
            
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Прізвище'),
            ),
            
            TextField(
              controller: _gradeController,
              decoration: const InputDecoration(labelText: 'Оцінка'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            
            //дропдауни
            DropdownButtonFormField<Department>(
              initialValue: _selectedDepartment,
              items: Department.values
                  .map(
                    (department) => DropdownMenuItem(
                      value: department,
                      child: Text(department.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedDepartment = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Спеціальність'),
            ),
            
            
            DropdownButtonFormField<Gender>(
              initialValue: _selectedGender,
              items: Gender.values
                  .map(
                    (gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedGender = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Стать'),
            ),
            const SizedBox(height: 20),
            
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  child: const Text('Скасувати'),
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: const Text('Зберегти'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}