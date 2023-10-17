import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  // Instrument service
  HttpWeatherRepository weatherRepository = HttpWeatherRepository();

  group('Test API Integration', () {
    Location location = Location(latitude: -25.777135, longitude: 28.257721);

    test('should return city', () async {
      final weather = await weatherRepository.getWeatherForLocation(location);
      expect(weather.city, isNotEmpty);
      expect(weather.city, isNot(equals('Unknown')));
    });

    test('should return description', () async {
      final weather = await weatherRepository.getWeatherForLocation(location);
      expect(weather.description, isNotEmpty);
    });

    test('should return condition', () async {
      final weather = await weatherRepository.getWeatherForLocation(location);
      expect(weather.condition, isNot(equals(WeatherCondition.unknown)));
    });

    test('should return date', () async {
      final weather = await weatherRepository.getWeatherForLocation(location);
      expect(weather.date.millisecondsSinceEpoch, isNot(equals(0)));
    });

    test('should return temperatures', () async {
      final weather = await weatherRepository.getWeatherForLocation(location);
      expect(weather.temperature, isNot(equals(-100)));
      expect(weather.minTemperature, isNot(equals(-100)));
      expect(weather.maxTemperature, isNot(equals(-100)));
    });
  });
}