import 'package:weather_app/domain/models/models.dart';
import 'package:weather_app/domain/state/state.dart';

class WeatherState {

  final List<WeatherPage> pages;
  final Location? currentLocation;
  final bool loading;

  WeatherState({
    required this.pages,
    required this.currentLocation,
    required this.loading,
  });

  WeatherState.initial()
    : pages = [],
      currentLocation = null,
      loading = false;

  WeatherState copyWith({
    List<WeatherPage>? pages,
    Location? currentLocation,
    bool? loading,
  }) {
    return WeatherState(
      pages: pages ?? this.pages,
      currentLocation: currentLocation ?? this.currentLocation,
      loading: loading ?? this.loading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherState &&
          runtimeType == other.runtimeType &&
          pages == other.pages &&
          currentLocation == other.currentLocation &&
          loading == other.loading;

  @override
  int get hashCode =>
      pages.hashCode ^ currentLocation.hashCode ^ loading.hashCode;
}