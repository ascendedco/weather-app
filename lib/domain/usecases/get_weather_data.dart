import 'package:weather_app/domain/domain.dart';

class GetWeatherData extends UseCaseFuture<void, void> {
  
  final GetLocation getLocation;
  final GetForecast getForecast;
  final GetWeather getWeather;
  final StateManager stateManager;
  
  GetWeatherData({
    required this.getLocation,
    required this.getForecast,
    required this.getWeather,
    required this.stateManager,
  });

  @override
  Future<void> execute(void input) async {
    stateManager.setLoading(true);
    
    try {
      Location location = await getLocation.execute(null);
      Weather weather = await getWeather.execute(null);
      List<Weather> forecast = await getForecast.execute(null);

      stateManager.setLocation(location);
      stateManager.setWeatherPages([
        WeatherPage(
          location: location,
          currentWeather: weather,
          forecast: forecast,
        ),
      ]);

      stateManager.setLoading(false);
    }
    catch (ex) {
      stateManager.setLoading(false);
      rethrow;
    }
  }
}