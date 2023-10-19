import 'package:weather_app/domain/domain.dart';

class MockLocationService implements LocationService {

  Location _location = Location(latitude: -25.777135, longitude: 28.257721);
  bool _permissionGranted = false;
  bool _permissionGrantedAfterRequest = false;

  set permissionGranted(bool value) {
    _permissionGranted = value;
  }

  set permissionGrantedAfterRequest(bool value) {
    _permissionGrantedAfterRequest = value;
  }

  set location(Location value) {
    _location = value;
  }

  @override
  Future<Location> getCurrentLocation() async {
    return Future.value(_location);
  }

  @override
  Future<bool> hasLocationPermission() {
    return Future.value(_permissionGranted);
  }

  @override
  Future<bool> requestLocationPermission() {
    return Future.value(_permissionGrantedAfterRequest);
  }
}