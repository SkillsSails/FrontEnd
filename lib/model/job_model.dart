import 'package:intl/intl.dart';

class Job {
  final String id;
  final String title;
  final String description;
  final String location;
  final String userId;
  final double salary;
  final DateTime datePosted;
  final List<String> requirements;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.userId,
    required this.salary,
    required this.datePosted,
    required this.requirements,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'', 'en_US');

    double parseSalary(dynamic salary) {
      if (salary is num) {
        return salary.toDouble();
      } else if (salary is String) {
        return double.tryParse(salary) ?? 0.0;
      } else {
        throw Exception("Invalid salary type");
      }
    }

    return Job(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      userId: json['user_id'] as String,
      salary: parseSalary(json['salary']),
      datePosted: dateFormat.parse(json['date_posted'] as String),
      requirements: List<String>.from(json['requirements']),
    );
  }
}
