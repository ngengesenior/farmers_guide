class Weather {
  final String date;
  final String description;
  final double humidity;
  final double precipitation;
  final double temperatureHigh;
  final double temperatureLow;
  final double windSpeed;

  Weather({
    required this.date,
    required this.description,
    required this.humidity,
    required this.precipitation,
    required this.temperatureHigh,
    required this.temperatureLow,
    required this.windSpeed,
  });

  // Factory method to create a Weather from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: json['date'],
      description: json['description'] ?? '',
      humidity: double.parse(json['humidity'].toString()),
      precipitation: double.parse(json['precipitation'].toString()),
      temperatureHigh: double.parse(json['temperature_high'].toString()),
      temperatureLow: double.parse(json['temperature_low'].toString()),
      windSpeed: double.parse(json['wind_speed'].toString()),
    );
  }

  // Method to convert a Weather instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
      'humidity': humidity,
      'precipitation': precipitation,
      'temperature_high': temperatureHigh,
      'temperature_low': temperatureLow,
      'wind_speed': windSpeed,
    };
  }

  // Method to create a copy of the Weather with updated values
  Weather copyWith({
    String? date,
    String? description,
    double? humidity,
    double? precipitation,
    double? temperatureHigh,
    double? temperatureLow,
    double? windSpeed,
  }) {
    return Weather(
      date: date ?? this.date,
      description: description ?? this.description,
      humidity: humidity ?? this.humidity,
      precipitation: precipitation ?? this.precipitation,
      temperatureHigh: temperatureHigh ?? this.temperatureHigh,
      temperatureLow: temperatureLow ?? this.temperatureLow,
      windSpeed: windSpeed ?? this.windSpeed,
    );
  }

  @override
  String toString() {
    return 'Weather(date: $date, description: $description, humidity: $humidity, humidity: $humidity, temperatureHigh: $temperatureHigh)';
  }
}
