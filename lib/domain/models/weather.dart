enum WeatherCondition {
  clear,
  rain,
  partlyCloudy,
  unknown
}

class Weather {

  final String city;
  final String description;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final WeatherCondition condition;
  final DateTime date;

  Weather({
    required this.city,
    required this.description,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.condition,
    required this.date,
  });

  Weather copyWith({
    String? city,
    String? description,
    double? temperature,
    double? minTemperature,
    double? maxTemperature,
    WeatherCondition? condition,
    DateTime? date,
  }) {
    return Weather(
      city: city ?? this.city,
      description: description ?? this.description,
      temperature: temperature ?? this.temperature,
      minTemperature: minTemperature ?? this.minTemperature,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      condition: condition ?? this.condition,
      date: date ?? this.date,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          description == other.description &&
          temperature == other.temperature &&
          minTemperature == other.minTemperature &&
          maxTemperature == other.maxTemperature &&
          condition == other.condition &&
          date == other.date;

  @override
  int get hashCode =>
      city.hashCode ^
      description.hashCode ^
      temperature.hashCode ^
      minTemperature.hashCode ^
      maxTemperature.hashCode ^
      condition.hashCode ^
      date.hashCode;
}