class CropDisease {
  final int farmId;
  final bool isInfected;
  final String cropName;
  final String cropType;
  final String diseaseName;
  final String treatmentRecommendation;
  final String howToIdentifyDisease;
  final String causesOfDisease;
  final String otherThingsToNote;
  final double confidenceLevel;
  final List<dynamic> images;

  CropDisease({
    required this.farmId,
    required this.isInfected,
    required this.cropName,
    required this.cropType,
    required this.diseaseName,
    required this.treatmentRecommendation,
    required this.howToIdentifyDisease,
    required this.causesOfDisease,
    required this.otherThingsToNote,
    required this.confidenceLevel,
    required this.images,
  });

  // Factory method to create a CropDisease from JSON
  factory CropDisease.fromJson(Map<String, dynamic> json) {
    return CropDisease(
      farmId: json['farm_id'] ?? 0,
      isInfected: json['is_infected'] ?? true,
      cropName: json['crop_name'],
      cropType: json['crop_type'],
      diseaseName: json['disease_name'],
      treatmentRecommendation: json['treatment_recommendation'],
      howToIdentifyDisease: json['how_to_identify_disease'] ?? '',
      causesOfDisease: json['causes_of_disease'] ?? '',
      otherThingsToNote: json['other_things_to_note'] ?? '',
      confidenceLevel: json['confidence_level'] ?? '',
      images: json['images'] ?? [],
    );
  }

  // Method to convert a CropDisease instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'farm_id': farmId,
      'is_infected': isInfected,
      'crop_name': cropName,
      'crop_type': cropType,
      'disease_name': diseaseName,
      'treatment_recommendation': treatmentRecommendation,
      'how_to_identify_disease': howToIdentifyDisease,
      'causes_of_disease': causesOfDisease,
      'other_things_to_note': otherThingsToNote,
      'confidence_level': confidenceLevel,
      'images': images,
    };
  }

  // Method to create a copy of the CropDisease with updated values
  CropDisease copyWith({
    int? farmId,
    bool? isInfected,
    String? cropName,
    String? cropType,
    String? diseaseName,
    String? treatmentRecommendation,
    String? howToIdentifyDisease,
    String? causesOfDisease,
    String? otherThingsToNote,
    double? confidenceLevel,
    List<String>? images,
  }) {
    return CropDisease(
      farmId: farmId ?? this.farmId,
      isInfected: isInfected ?? this.isInfected,
      cropName: cropName ?? this.cropName,
      cropType: cropType ?? this.cropType,
      diseaseName: diseaseName ?? this.diseaseName,
      treatmentRecommendation:
          treatmentRecommendation ?? this.treatmentRecommendation,
      howToIdentifyDisease: howToIdentifyDisease ?? this.howToIdentifyDisease,
      causesOfDisease: causesOfDisease ?? this.causesOfDisease,
      otherThingsToNote: otherThingsToNote ?? this.otherThingsToNote,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
      images: images ?? this.images,
    );
  }

  @override
  String toString() {
    return 'CropDisease(crop_name: $cropName, crop_type: $cropType, disease_name: $diseaseName, disease_name: $diseaseName, how_to_identify_disease: $howToIdentifyDisease)';
  }
}
