import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/repositories/mappers/mappers.dart';
import 'package:weather_app/repositories/models/models.dart';

void main() {
  // Instrument data
  WeatherResponse krugersdorpResponse = WeatherResponse.fromJson(krugersdorpData);
  Weather krugersdorpWeather = krugersdorpResponse.toModel();

  WeatherResponse pretoriaResponse = WeatherResponse.fromJson(pretoriaData);
  Weather pretoriaWeather = pretoriaResponse.toModel();

  group('Test Weather Mapper', () {

    test('should match city', () async {
      expect(krugersdorpWeather.city, 'Krugersdorp');
      expect(pretoriaWeather.city, 'Waterkloof');
    });

    test('should match description', () async {
      expect(krugersdorpWeather.description, 'Clear: clear sky');
      expect(pretoriaWeather.description, 'Clouds: partly cloudy');
    });

    test('should match temperature', () async {
      expect(krugersdorpWeather.temperature, 13.37);
      expect(pretoriaWeather.temperature, 14.4);
    });

    test('should match min temperature', () async {
      expect(krugersdorpWeather.minTemperature, 11.73);
      expect(pretoriaWeather.minTemperature, 13.29);
    });

    test('should match max temperature', () async {
      expect(krugersdorpWeather.maxTemperature, 14.05);
      expect(pretoriaWeather.maxTemperature, 15.62);
    });

    test('should match condition', () async {
      expect(krugersdorpWeather.condition, WeatherCondition.clear);
      expect(pretoriaWeather.condition, WeatherCondition.partlyCloudy);
    });

    test('should match date', () async {
      expect(krugersdorpWeather.date, DateTime.fromMillisecondsSinceEpoch(1697570404 * 1000));
      expect(pretoriaWeather.date, DateTime.fromMillisecondsSinceEpoch(1697570488 * 1000));
    });
  });
}

final Map<String, dynamic> krugersdorpData = {
  "coord": {
    "lon": 27.8188,
    "lat": -26.0897
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01n"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 13.37,
    "feels_like": 12.41,
    "temp_min": 11.73,
    "temp_max": 14.05,
    "pressure": 1024,
    "humidity": 63
  },
  "visibility": 10000,
  "wind": {
    "speed": 5.66,
    "deg": 110
  },
  "clouds": {
    "all": 0
  },
  "dt": 1697570404,
  "sys": {
    "type": 2,
    "id": 2008899,
    "country": "ZA",
    "sunrise": 1697513534,
    "sunset": 1697559346
  },
  "timezone": 7200,
  "id": 986822,
  "name": "Krugersdorp",
  "cod": 200
};

final Map<String, dynamic> pretoriaData = {
  "coord": {
    "lon": 28.2577,
    "lat": -25.7771
  },
  "weather": [
    {
      "id": 800,
      "main": "Clouds",
      "description": "partly cloudy",
      "icon": "01n"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 14.4,
    "feels_like": 13.72,
    "temp_min": 13.29,
    "temp_max": 15.62,
    "pressure": 1024,
    "humidity": 70
  },
  "visibility": 10000,
  "wind": {
    "speed": 4.63,
    "deg": 130
  },
  "clouds": {
    "all": 0
  },
  "dt": 1697570488,
  "sys": {
    "type": 1,
    "id": 2001,
    "country": "ZA",
    "sunrise": 1697513445,
    "sunset": 1697559225
  },
  "timezone": 7200,
  "id": 941728,
  "name": "Waterkloof",
  "cod": 200
};