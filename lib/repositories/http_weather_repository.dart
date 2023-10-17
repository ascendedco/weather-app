import 'dart:convert';

import 'package:weather_app/domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/repositories/models/models.dart';
import 'package:weather_app/repositories/mappers/mappers.dart';

class HttpWeatherRepository implements WeatherRepository {

  final String _apiKey = '8548f54704dfcf4b48ec2be11eab6ea8';

  @override
  Future<Weather> getWeatherForLocation(Location location) async {
    final String url = 'https://api.openweathermap.org/data/2.5/weather?'
        'lat=${location.latitude}&'
        'lon=${location.longitude}&'
        'appid=$_apiKey&'
        'units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body)).toModel();
    } else {
      throw Exception('Could not load weather. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<List<Weather>> getForecastForLocation(Location location) async {
    final String url = 'https://api.openweathermap.org/data/2.5/forecast?'
        'lat=${location.latitude}&'
        'lon=${location.longitude}&'
        'appid=$_apiKey&'
        'units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> items = jsonDecode(response.body)['list']
          .where((i) => (i['dt_txt'] as String).contains('12:00:00'))
          .toList();

      return items.map((e) => WeatherResponse.fromJson(e).toModel()).toList();
    } else {
      throw Exception('Could not load weather. Status code: ${response.statusCode}');
    }
  }
}