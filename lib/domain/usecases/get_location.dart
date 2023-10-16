import 'package:weather_app/domain/domain.dart';

class GetLocation extends UseCaseFuture<void, Location> {

  final LocationService locationService;

  GetLocation({ required this.locationService });

  @override
  Future<Location> execute(void input) async {
    bool hasPermission = await locationService.hasLocationPermission();
    if (!hasPermission) {
      bool permissionGranted = await locationService.requestLocationPermission();
      if (!permissionGranted) {
        throw Exception('Location permission not granted');
      }
    }
    return await locationService.getCurrentLocation();
  }
}