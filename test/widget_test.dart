import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/state/state.dart';
import 'package:weather_app/widgets/forecast_widget.dart';
import 'package:weather_app/widgets/temperature_widget.dart';
import 'package:weather_app/widgets/weather_layout_widget.dart';

import 'dependencies.dart';
import 'services/mock_location_service.dart';

void main() {
  testWidgets('should show empty text and loading indicator', (WidgetTester tester) async {
    // Simulate iPhone 14 Pro Screen
    await tester.binding.setSurfaceSize(const Size(393, 852));

    // Build our main layout widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WeatherLayoutWidget(page: null, loading: true),
        ),
      ),
    );
    await tester.pump();

    // Verify that we have multiple text placeholders
    expect(find.text('-'), findsWidgets);

    // Verify that we have loading indicator
    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  });

  testWidgets('should show 20 and cloudy', (WidgetTester tester) async {
    // Simulate iPhone 14 Pro Screen
    await tester.binding.setSurfaceSize(const Size(393, 852));

    // Build our dependency tree
    registerDependencies();
    await initDependencies();

    // Get all the dependencies we need
    final locationService = locator.get<LocationService>();
    final weatherState = locator.get<WeatherStateManager>();
    final getWeatherData = locator.get<GetWeatherData>();

    // Perform required casts
    locationService as MockLocationService;
    weatherState as WeatherProvider;

    // Set location permissions
    locationService.permissionGranted = true;

    // Execute getWeatherData to populate app state
    await getWeatherData.execute(null);

    // Build our main layout widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WeatherLayoutWidget(
            page: weatherState.state.pages.firstOrNull,
            loading: weatherState.state.loading,
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify that we have the correct text displayed
    expect(find.text('20\u00B0'), findsWidgets);
    expect(find.text('CLOUDY'), findsWidgets);

    // Verify that we have no loading indicator
    expect(
      find.byType(CircularProgressIndicator),
      findsNothing,
    );
  });

  testWidgets('should render temperature widget correctly', (WidgetTester tester) async {
    // Simulate iPhone 14 Pro Screen
    await tester.binding.setSurfaceSize(const Size(393, 852));

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TemperatureWidget(
            temperature: 25,
            label: 'Current',
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify that we have the correct text displayed
    expect(find.text('25\u00B0'), findsOneWidget);
    expect(find.text('Current'), findsOneWidget);
  });

  testWidgets('should render forecast widget correctly', (WidgetTester tester) async {
    // Simulate iPhone 14 Pro Screen
    await tester.binding.setSurfaceSize(const Size(393, 852));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForecastWidget(
            temperature: 29,
            condition: WeatherCondition.clear,
            date: DateTime.utc(2023, 10, 19),
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify that we have the correct text displayed
    expect(find.text('29\u00B0'), findsOneWidget);
    expect(find.text('Thursday'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
