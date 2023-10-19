import 'package:weather_app/domain/models/models.dart';
import 'package:weather_app/domain/state/state.dart';

abstract class WeatherStateManager {
  void setLoading(bool loading);
  void setLocation(Location location);
  void setWeatherPages(List<WeatherPage> pages);
  void reset();
}