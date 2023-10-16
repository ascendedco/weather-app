import 'package:weather_app/domain/domain.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherForLocation(Location location);
  Future<List<Weather>> getForecastForLocation(Location location);
}