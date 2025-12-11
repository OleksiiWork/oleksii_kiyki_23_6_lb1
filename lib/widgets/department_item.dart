import 'package:flutter/material.dart';
import 'package:oleksii_kiyki_23_6_lb1/models/department.dart';

class DepartmentItem extends StatelessWidget {
  const DepartmentItem({
    super.key,
    required this.department,
    required this.studentCount,
  });

  final Department department;
  final int studentCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            department.color.withValues(alpha: 0.6),
            department.color.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            department.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Students enrolled: $studentCount',
            style: const TextStyle(color: Colors.white70),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(department.icon, size: 40, color: Colors.white),
          )
        ],
      ),
    );
  }
}