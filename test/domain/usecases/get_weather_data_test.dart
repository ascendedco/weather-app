import 'package:test/test.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/state/state.dart';

import '../../repositories/repositories.dart';
import '../../services/services.dart';

void main() {
  // Instrument mock service & repository
  LocationService locationService = MockLocationService();
  WeatherRepository weatherRepository = MockWeatherRepository();

  // Instrument mock usecases
  GetLocation getLocation = GetLocation(locationService: locationService);
  GetWeather getWeather = GetWeather(getLocation: getLocation, weatherRepository: weatherRepository);
  GetForecast getForecast = GetForecast(getLocation: getLocation, weatherRepository: weatherRepository);

  // Instrument state manager
  WeatherStateManager stateManager = WeatherProvider();

  group('Get Weather Data Use Case', () {

    stateManager as WeatherProvider;

    // No exceptions thrown, state should update
    test('should update state', () async {
      (locationService as MockLocationService).permissionGranted = true;

      final getWeatherData = GetWeatherData(
        getLocation: getLocation,
        getForecast: getForecast,
        getWeather: getWeather,
        weatherStateManager: stateManager,
      );

      await getWeatherData.execute(null);

      expect(stateManager.state.currentLocation, isNotNull);
      expect(stateManager.state.currentLocation?.latitude, -25.777135);
      expect(stateManager.state.currentLocation?.longitude, 28.257721);
      expect(stateManager.state.loading, false);
      expect(stateManager.state.pages, isNotEmpty);
    });

    // Exceptions thrown, state should not update
    test('should not update state', () async {
      (locationService as MockLocationService).permissionGranted = false;
      stateManager.reset();

      final getWeatherData = GetWeatherData(
        getLocation: getLocation,
        getForecast: getForecast,
        getWeather: getWeather,
        weatherStateManager: stateManager,
      );

      try {
        await getWeatherData.execute(null);
      } catch (_) { }

      expect(stateManager.state.currentLocation, isNull);
      expect(stateManager.state.loading, false);
      expect(stateManager.state.pages, isEmpty);
    });
  });
}