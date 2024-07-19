import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String? id;
  final String username;
  final String password;
  final String email;
  final String phoneNumber;
  final String github;
  final String linkedin;
  final List<String> technicalSkills;
  final List<String> professionalSkills;
  final Map<String, dynamic> certification;
  final String? role;
  final List<String> jobs;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.github,
    required this.linkedin,
    this.technicalSkills = const [],
    this.professionalSkills = const [],
    this.certification = const {
      "organization": null,
      "name": null,
      "year": null,
    },
    this.role,
    this.jobs = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      username: json['username'] as String,
      password: json['password'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      github: json['github'] as String? ?? '',
      linkedin: json['linkedin'] as String? ?? '',
      technicalSkills: List<String>.from(json['technical_skills'] ?? []),
      professionalSkills: List<String>.from(json['professional_skills'] ?? []),
      certification: Map<String, dynamic>.from(json['certification'] ?? {
        "organization": null,
        "name": null,
        "year": null,
      }),
      role: json['role'] as String?,
      jobs: List<String>.from(json['jobs'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'email': email,
      'phone_number': phoneNumber,
      'github': github,
      'linkedin': linkedin,
      'technical_skills': technicalSkills,
      'professional_skills': professionalSkills,
      'certification': certification,
      'role': role,
      'jobs': jobs,
    };
  }
}
