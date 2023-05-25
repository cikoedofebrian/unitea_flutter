import 'package:unitea_flutter/models/faculty.dart';

class User {
  final int id;
  final String name;
  final DateTime createdAt;
  final Faculty faculty;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.faculty,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        faculty: Faculty.fromJson(json["faculty"]),
        email: json["email"],
      );
}
