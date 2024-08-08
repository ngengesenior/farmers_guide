class Register {
  final String username;
  final String email;
  final String password;

  Register({
    required this.username,
    required this.email,
    required this.password,
  });

  // Factory method to create a Register from JSON
  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  // Method to convert a Register instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Method to create a copy of the Register with updated values
  Register copyWith({
    String? username,
    String? email,
    String? password,
  }) {
    return Register(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'Register(username: $username, email: $email, password: $password)';
  }
}
