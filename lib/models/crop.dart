class Crop {
  final int id;
  final int farmId;
  final String notes;
  final String cropType;
  final String createdAt;
  final String plantedOn;
  final String updatedAt;
  final String havestedOn;

  Crop({
    required this.id,
    required this.farmId,
    required this.notes,
    required this.cropType,
    required this.createdAt,
    required this.plantedOn,
    required this.updatedAt,
    required this.havestedOn,
  });

  // Factory method to create a Crop from JSON
  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'] ?? 0,
      farmId: json['farm_id'] ?? 0,
      notes: json['notes'],
      cropType: json['crop_type'],
      createdAt: json['created_at'] ?? '',
      plantedOn: json['planted_on'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      havestedOn: json['havested_on'] ?? '',
    );
  }

  // Method to convert a Crop instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farm_id': farmId,
      'notes': notes,
      'crop_type': cropType,
      'created_at': createdAt,
      'planted_on': plantedOn,
      'updated_at': updatedAt,
      'havested_on': havestedOn,
    };
  }

  // Method to create a copy of the Crop with updated values
  Crop copyWith({
    int? id,
    int? farmId,
    String? notes,
    String? cropType,
    double? latitude,
    double? longitude,
    String? createdAt,
    String? plantedOn,
    String? updatedAt,
    String? havestedOn,
  }) {
    return Crop(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      notes: notes ?? this.notes,
      cropType: cropType ?? this.cropType,
      createdAt: createdAt ?? this.createdAt,
      plantedOn: plantedOn ?? this.plantedOn,
      updatedAt: updatedAt ?? this.updatedAt,
      havestedOn: havestedOn ?? this.havestedOn,
    );
  }

  @override
  String toString() {
    return 'Crop(notes: $notes, crop_type: $cropType, createdAt: $createdAt)';
  }
}
