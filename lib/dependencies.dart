import 'package:get_it/get_it.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:weather_app/services/services.dart';
import 'package:weather_app/state/state.dart';

final locator = GetIt.instance;

void registerDependencies() {
  // Register repositories
  locator.registerFactory<WeatherRepository>(() => HttpWeatherRepository());

  // Register services
  locator.registerFactory<LocationService>(() => FlutterLocationService());

  // Register state managers
  locator.registerSingleton<WeatherStateManager>(WeatherProvider());

  // Register use cases
  locator.registerFactory<GetLocation>(() => GetLocation(locationService: locator()));
  locator.registerFactory<GetWeather>(
    () => GetWeather(
      getLocation: locator(),
      weatherRepository: locator(),
    ),
  );
  locator.registerFactory<GetForecast>(
    () => GetForecast(
      getLocation: locator(),
      weatherRepository: locator(),
    ),
  );
  locator.registerFactory<GetWeatherData>(
    () => GetWeatherData(
      getLocation: locator(),
      getForecast: locator(),
      getWeather: locator(),
      weatherStateManager: locator(),
    ),
  );
}

Future<void> initDependencies() async {
  await locator.allReady();
}