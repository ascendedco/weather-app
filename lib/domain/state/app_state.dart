import 'package:weather_app/domain/models/models.dart';
import 'package:weather_app/domain/state/state.dart';

class AppState {

  final List<WeatherPage> pages;
  final Location? currentLocation;
  final bool loading;

  AppState({
    required this.pages,
    required this.currentLocation,
    required this.loading,
  });

  AppState.initial()
    : pages = [],
      currentLocation = null,
      loading = false;

  AppState copyWith({
    List<WeatherPage>? pages,
    Location? currentLocation,
    bool? loading,
  }) {
    return AppState(
      pages: pages ?? this.pages,
      currentLocation: currentLocation ?? this.currentLocation,
      loading: loading ?? this.loading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          pages == other.pages &&
          currentLocation == other.currentLocation &&
          loading == other.loading;

  @override
  int get hashCode =>
      pages.hashCode ^ currentLocation.hashCode ^ loading.hashCode;
}