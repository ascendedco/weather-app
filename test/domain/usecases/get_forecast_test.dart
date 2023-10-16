import 'package:test/test.dart';
import 'package:weather_app/domain/domain.dart';

import '../../repositories/repositories.dart';
import '../../services/services.dart';

void main() {
  // Instrument mock service
  LocationService locationService = MockLocationService();
  WeatherRepository weatherRepository = MockWeatherRepository();
  GetLocation getLocation = GetLocation(locationService: locationService);

  group('Get Forecast Use Case', () {
    (locationService as MockLocationService).permissionGranted = true;

    test('should return forecast', () async {
      final getForecast = GetForecast(getLocation: getLocation, weatherRepository: weatherRepository);
      List<Weather> forecast = await getForecast.execute(null);
      expect(forecast.first.city, 'Pretoria');
      expect(forecast.length, 5);
    });

    // Mock service doesn't have weather for the location, the use case should throw an exception
    test('should fail with exception', () {
      locationService.location = Location(latitude: -26.089678, longitude: 27.818802);
      final getForecast = GetForecast(getLocation: getLocation, weatherRepository: weatherRepository);
      expect(() => getForecast.execute(null), throwsException);
    });
  });
}