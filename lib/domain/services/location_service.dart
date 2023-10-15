import 'package:weather_app/domain/domain.dart';

abstract class LocationService {
  Future<Location> getCurrentLocation();
  Future<bool> hasLocationPermission();
  Future<bool> requestLocationPermission();
}