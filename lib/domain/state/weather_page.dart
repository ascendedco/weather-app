import 'package:weather_app/domain/domain.dart';

class WeatherPage {

  final Location location;
  final Weather currentWeather;
  final List<Weather> forecast;

  WeatherPage({
    required this.location,
    required this.currentWeather,
    required this.forecast,
  });

  WeatherPage copyWith({
    Location? location,
    Weather? currentWeather,
    List<Weather>? forecast,
  }) {
    return WeatherPage(
      location: location ?? this.location,
      currentWeather: currentWeather ?? this.currentWeather,
      forecast: forecast ?? this.forecast,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherPage &&
          runtimeType == other.runtimeType &&
          location == other.location &&
          currentWeather == other.currentWeather &&
          forecast == other.forecast;

  @override
  int get hashCode =>
      location.hashCode ^ currentWeather.hashCode ^ forecast.hashCode;
}