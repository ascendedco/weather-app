import 'package:test/test.dart';
import 'package:weather_app/domain/domain.dart';

import '../../services/services.dart';

void main() {
  // Instrument mock service
  LocationService locationService = MockLocationService();

  group('Get Location Use Case', () {
    // Location permission is not granted, the use case should throw an exception
    test('should fail with exception', () {
      final getLocation = GetLocation(locationService: locationService);
      expect(() => getLocation.execute(null), throwsException);
    });

    // Location permission is not granted, but granted after request, the use case
    // should return a location
    test('should return a location', () async {
      // Set location permission to false
      (locationService as MockLocationService).permissionGranted = false;
      // Set location permission to true after request
      locationService.permissionGrantedAfterRequest = true;
      final getLocation = GetLocation(locationService: locationService);
      Location location = await getLocation.execute(null);
      expect(location.latitude, -25.777135);
      expect(location.longitude, 28.257721);
    });

    // Location permission is already granted, the use case should return a location
    test('should return a location', () async {
      // Set location permission to true
      (locationService as MockLocationService).permissionGranted = true;
      final getLocation = GetLocation(locationService: locationService);
      Location location = await getLocation.execute(null);
      expect(location.latitude, -25.777135);
      expect(location.longitude, 28.257721);
    });
  });
}