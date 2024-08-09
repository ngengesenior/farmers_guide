class Farm {
  final String id;
  final String name;
  final double size;
  final double latitude;
  final double longitude;
  final String createdAt;
  final String updatedAt;

  Farm({
    required this.id,
    required this.name,
    required this.size,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Farm from JSON
  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'] ?? '',
      name: json['name'],
      size: double.parse(json['size']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Method to convert a Farm instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Method to create a copy of the Farm with updated values
  Farm copyWith({
    String? id,
    String? name,
    double? size,
    double? latitude,
    double? longitude,
    String? createdAt,
    String? updatedAt,
  }) {
    return Farm(
      id: id ?? this.id,
      name: name ?? this.name,
      size: size ?? this.size,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Farm(name: $name, size: $size, latitude: $latitude, latitude: $latitude, createdAt: $createdAt)';
  }
}
