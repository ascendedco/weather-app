import 'package:flutter/foundation.dart';
import 'package:weather_app/domain/domain.dart';

class WeatherProvider extends ChangeNotifier implements WeatherStateManager {

  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;

  @override
  void reset() {
    _state = WeatherState.initial();
    notifyListeners();
  }

  @override
  void setLoading(bool loading) {
    _state = _state.copyWith(loading: loading);
    notifyListeners();
  }

  @override
  void setLocation(Location location) {
    _state = _state.copyWith(currentLocation: location);
    notifyListeners();
  }

  @override
  void setWeatherPages(List<WeatherPage> pages) {
    _state = _state.copyWith(pages: pages);
    notifyListeners();
  }
}
