import 'package:test/test.dart';
import 'package:weather_app/domain/domain.dart';

import '../../repositories/repositories.dart';
import '../../services/services.dart';

void main() {
  // Instrument mock service
  LocationService locationService = MockLocationService();
  WeatherRepository weatherRepository = MockWeatherRepository();
  GetLocation getLocation = GetLocation(locationService: locationService);

  group('Get Weather Use Case', () {
    (locationService as MockLocationService).permissionGranted = true;

    // Mock service has weather for the default location, city and temperature should match expectation
    test('should return weather', () async {
      final getWeather = GetWeather(getLocation: getLocation, weatherRepository: weatherRepository);
      Weather weather = await getWeather.execute(null);
      expect(weather.city, 'Pretoria');
      expect(weather.temperature, 20);
    });

    // Mock service doesn't have weather for the location, the use case should throw an exception
    test('should fail with exception', () {
      locationService.location = Location(latitude: -26.089678, longitude: 27.818802);
      final getWeather = GetWeather(getLocation: getLocation, weatherRepository: weatherRepository);
      expect(() => getWeather.execute(null), throwsException);
    });
  });
}