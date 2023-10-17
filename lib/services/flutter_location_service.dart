import 'package:weather_app/domain/domain.dart';
import 'package:location/location.dart' as l;

class FlutterLocationService implements LocationService {

  final l.Location _location = l.Location();

  @override
  Future<Location> getCurrentLocation() async {
    l.LocationData data = await _location.getLocation();
    return Location(latitude: data.latitude ?? 0, longitude: data.longitude ?? 0);
  }

  @override
  Future<bool> requestLocationPermission() async {
    final l.PermissionStatus status = await _location.requestPermission();
    return status == l.PermissionStatus.granted || status == l.PermissionStatus.grantedLimited;
  }

  @override
  Future<bool> hasLocationPermission() async {
    final l.PermissionStatus status = await _location.hasPermission();
    return status == l.PermissionStatus.granted || status == l.PermissionStatus.grantedLimited;
  }
}