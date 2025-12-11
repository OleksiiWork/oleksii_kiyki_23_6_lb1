import 'package:uuid/uuid.dart';

enum Gender { male, female }

const uuid = Uuid();

class Student {
  Student({
    String? id,
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.grade,
    required this.gender,
  }) : id = id ?? uuid.v4();

  final String id;
  final String firstName;
  final String lastName;
  final String departmentId;
  final int grade;
  final Gender gender;

  Student copyWith({
    String? firstName,
    String? lastName,
    String? departmentId,
    int? grade,
    Gender? gender,
  }) {
    return Student(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      departmentId: departmentId ?? this.departmentId,
      grade: grade ?? this.grade,
      gender: gender ?? this.gender,
    );
  }
}