import 'package:weather_app/domain/domain.dart';

class GetForecast extends UseCaseFuture<void, List<Weather>> {

  final GetLocation getLocation;
  final WeatherRepository weatherRepository;

  GetForecast({
    required this.getLocation,
    required this.weatherRepository,
  });

  @override
  Future<List<Weather>> execute(void input) async {
    Location location = await getLocation.execute(null);
    List<Weather> forecast = await weatherRepository.getForecastForLocation(location);
    return forecast;
  }
}