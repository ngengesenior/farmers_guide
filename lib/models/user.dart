import 'dart:convert';

import 'package:farmers_guide/models/farm.dart';

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.farms,
  });

  final int id;
  final String username;
  final String email;
  final String createdAt;
  final String updatedAt;
  final List<Farm> farms;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json['username'],
        email: json["email"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        farms: (json["farms"] as List).map((e) => Farm.fromJson(e)).toList(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "farms": farms,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
