import 'package:weather_app/domain/domain.dart';

class MockWeatherRepository implements WeatherRepository {

  Map<String, Weather> _weather = {
    '-25.777135,28.257721': Weather(
      city: 'Pretoria',
      description: 'Cloudy with a chance of meatballs',
      temperature: 20,
      minTemperature: 16,
      maxTemperature: 23,
      condition: WeatherCondition.partlyCloudy,
      date: DateTime.now(),
    ),
  };

  set weather(Map<String, Weather> weather) => _weather = weather;

  Map<String, List<Weather>> _forecast = {
    '-25.777135,28.257721': [
      Weather(
        city: 'Pretoria',
        description: 'Cloudy with a chance of meatballs',
        temperature: 20,
        minTemperature: 16,
        maxTemperature: 23,
        condition: WeatherCondition.partlyCloudy,
        date: DateTime.now(),
      ),
      Weather(
        city: 'Pretoria',
        description: 'Sunny',
        temperature: 25,
        minTemperature: 20,
        maxTemperature: 28,
        condition: WeatherCondition.clear,
        date: DateTime.now().add(const Duration(days: 1)),
      ),
      Weather(
        city: 'Pretoria',
        description: 'Rainy',
        temperature: 18,
        minTemperature: 15,
        maxTemperature: 20,
        condition: WeatherCondition.rain,
        date: DateTime.now().add(const Duration(days: 2)),
      ),
      Weather(
        city: 'Pretoria',
        description: 'Sunny',
        temperature: 25,
        minTemperature: 20,
        maxTemperature: 28,
        condition: WeatherCondition.clear,
        date: DateTime.now().add(const Duration(days: 3)),
      ),
      Weather(
        city: 'Pretoria',
        description: 'Cloudy with a chance of rain',
        temperature: 21,
        minTemperature: 18,
        maxTemperature: 23,
        condition: WeatherCondition.partlyCloudy,
        date: DateTime.now().add(const Duration(days: 4)),
      ),
    ]
  };

  set forecast(Map<String, List<Weather>> forecast) => _forecast = forecast;

  @override
  Future<Weather> getWeatherForLocation(Location location) {
    Weather? weather = _weather['${location.latitude},${location.longitude}'];
    if (weather == null) {
      throw Exception('No weather found for location');
    }
    return Future.value(weather);
  }

  @override
  Future<List<Weather>> getForecastForLocation(Location location) {
  List<Weather>? forecast = _forecast['${location.latitude},${location.longitude}'];
    if (forecast == null) {
      throw Exception('No forecast found for location');
    }
    return Future.value(forecast);
  }
}