class CropAdvice {
  final double confidenceLevel;
  final String advice;
  final String adviceType;
  final String otherThingsToNote;
  final String duration;

  CropAdvice({
    required this.confidenceLevel,
    required this.advice,
    required this.adviceType,
    required this.otherThingsToNote,
    required this.duration,
  });

  // Factory method to create a CropAdvice from JSON
  factory CropAdvice.fromJson(Map<String, dynamic> json) {
    return CropAdvice(
      confidenceLevel: double.parse(json['confidence_level']?.toString() ?? "-1.0"),
      advice: json['advice'],
      adviceType: json['advice_type'],
      otherThingsToNote: json['other_things_to_note'] ?? '',
      duration: json['duration'] ?? '',
    );
  }

  // Method to convert a CropAdvice instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'confidence_level': confidenceLevel,
      'advice': advice,
      'advice_type': adviceType,
      'other_things_to_note': otherThingsToNote,
      'duration': duration,
    };
  }

  // Method to create a copy of the CropAdvice with updated values
  CropAdvice copyWith({
    double? confidenceLevel,
    String? advice,
    String? adviceType,
    double? latitude,
    double? longitude,
    String? otherThingsToNote,
    String? duration,
  }) {
    return CropAdvice(
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
      advice: advice ?? this.advice,
      adviceType: adviceType ?? this.adviceType,
      otherThingsToNote: otherThingsToNote ?? this.otherThingsToNote,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return 'CropAdvice(advice: $advice, advice_type: $adviceType, other_things_to_note: $otherThingsToNote)';
  }
}
