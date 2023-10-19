import 'package:weather_app/domain/domain.dart';

class GetWeatherData extends UseCaseFuture<void, void> {
  
  final GetLocation getLocation;
  final GetForecast getForecast;
  final GetWeather getWeather;
  final WeatherStateManager weatherStateManager;
  
  GetWeatherData({
    required this.getLocation,
    required this.getForecast,
    required this.getWeather,
    required this.weatherStateManager,
  });

  @override
  Future<void> execute(void input) async {
    weatherStateManager.setLoading(true);
    
    try {
      Location location = await getLocation.execute(null);
      Weather weather = await getWeather.execute(null);
      List<Weather> forecast = await getForecast.execute(null);

      weatherStateManager.setLocation(location);
      weatherStateManager.setWeatherPages([
        WeatherPage(
          location: location,
          currentWeather: weather,
          forecast: forecast,
        ),
      ]);

      weatherStateManager.setLoading(false);
    }
    catch (ex) {
      weatherStateManager.setLoading(false);
      rethrow;
    }
  }
}