import 'package:weather_app/domain/domain.dart';

class GetWeather extends UseCaseFuture<void, Weather> {

  final GetLocation getLocation;
  final WeatherRepository weatherRepository;

  GetWeather({
    required this.getLocation,
    required this.weatherRepository,
  });

  @override
  Future<Weather> execute(void input) async {
    Location location = await getLocation.execute(null);
    Weather weather = await weatherRepository.getWeatherForLocation(location);
    return weather;
  }
}