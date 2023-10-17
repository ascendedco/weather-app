import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/repositories/models/models.dart';

extension WeatherMapper on WeatherResponse {

  Weather toModel() {
    WeatherItem? item = weather?.firstOrNull;
    String description = item == null ? '' : '${item.main}: ${item.description}';

    WeatherCondition condition = switch (item?.main) {
      'Clear' => WeatherCondition.clear,
      'Clouds' => WeatherCondition.partlyCloudy,
      'Rain' => WeatherCondition.rain,
      _ => WeatherCondition.unknown,
    };

    DateTime date = dt == null ?
    DateTime.fromMicrosecondsSinceEpoch(0) :
    DateTime.fromMillisecondsSinceEpoch(dt! * 1000);

    return Weather(
      city: name ?? 'Unknown',
      description: description,
      temperature: main?.temp ?? -100,
      minTemperature: main?.tempMin ?? -100,
      maxTemperature: main?.tempMax ?? -100,
      condition: condition,
      date: date,
    );
  }
}