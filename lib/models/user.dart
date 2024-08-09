import 'dart:convert';

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
  final List<dynamic> farms;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json['username'],
        email: json["email"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        farms: json["farms"],
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
