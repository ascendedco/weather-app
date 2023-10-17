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

    test('should return 5 forecast items', () async {
      final forecast = await weatherRepository.getForecastForLocation(location);
      expect(forecast.length, 5);
    });

    test('forecast items should differ by 1 day', () async {
      final forecast = await weatherRepository.getForecastForLocation(location);
      expect(forecast[4].date.difference(forecast[3].date), const Duration(days: 1));
      expect(forecast[3].date.difference(forecast[2].date), const Duration(days: 1));
      expect(forecast[2].date.difference(forecast[1].date), const Duration(days: 1));
      expect(forecast[1].date.difference(forecast[0].date), const Duration(days: 1));
    });
  });
}