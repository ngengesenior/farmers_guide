class AuthToken {
  final String accessToken;
  final String tokenType;

  AuthToken({
    required this.accessToken,
    required this.tokenType,
  });

  // Factory method to create an AuthToken from JSON
  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  // Method to convert an AuthToken instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }

  // Method to create a copy of the AuthToken with updated values
  AuthToken copyWith({
    String? accessToken,
    String? tokenType,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  @override
  String toString() {
    return 'AuthToken(accessToken: $accessToken, tokenType: $tokenType)';
  }
}
