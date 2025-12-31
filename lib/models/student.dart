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
    String? id, 
    String? firstName,
    String? lastName,
    String? departmentId,
    int? grade,
    Gender? gender,
  }) {
    return Student(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      departmentId: departmentId ?? this.departmentId,
      grade: grade ?? this.grade,
      gender: gender ?? this.gender,
    );
  }

  // Перетворення об'єкта в Map (для JSON)
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      'grade': grade,
      'gender': gender.name,
    };
  }

  // Створення об'єкта з Map (з JSON)
  factory Student.fromJson(Map<String, dynamic> json, String id) {
    return Student(
      id: id, // ID приходить окремо як ключ в Firebase
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      departmentId: json['departmentId'] as String,
      grade: json['grade'] as int,
      gender: Gender.values.firstWhere((g) => g.name == json['gender']),
    );
  }
}