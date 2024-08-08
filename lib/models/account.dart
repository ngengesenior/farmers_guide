class RegisterResponse {
  final String username;
  final String email;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> farms;

  RegisterResponse({
    required this.username,
    required this.email,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.farms,
  });

  // Factory method to create a RegisterResponse from JSON
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      username: json['username'],
      email: json['email'],
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      farms: List<dynamic>.from(json['farms']),
    );
  }

  // Method to convert a RegisterResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'farms': farms,
    };
  }

  // Method to create a copy of the RegisterResponse with updated values
  RegisterResponse copyWith({
    String? username,
    String? email,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? farms,
  }) {
    return RegisterResponse(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      farms: farms ?? this.farms,
    );
  }

  @override
  String toString() {
    return 'RegisterResponse(username: $username, email: $email, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, farms: $farms)';
  }
}
