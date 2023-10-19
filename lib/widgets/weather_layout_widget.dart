import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/state/state.dart';
import 'package:weather_app/widgets/widgets.dart';

class WeatherLayoutWidget extends StatelessWidget {

  const WeatherLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    const double aspectRatio = 320 / 360;
    final double imageHeight = size.width * aspectRatio;

    return Consumer<WeatherProvider>(
      builder: (context, value, child) {
        final WeatherState state = value.state;
        final WeatherPage? page = state.pages.firstOrNull;
        final double? current = page?.currentWeather.temperature;
        final double? min = page?.currentWeather.minTemperature;
        final double? max = page?.currentWeather.maxTemperature;
        final WeatherCondition? condition = page?.currentWeather.condition;

        return Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      switch (condition) {
                        WeatherCondition.clear => 'assets/images/sea_sunny.png',
                        WeatherCondition.partlyCloudy => 'assets/images/sea_cloudy.png',
                        WeatherCondition.rain => 'assets/images/sea_rainy.png',
                        _ => 'assets/images/sea_sunny.png',
                      },
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: imageHeight,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              current != null ?
                                '${current.toStringAsFixed(0)}\u00B0' :
                                '-',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              switch (page?.currentWeather.condition) {
                                WeatherCondition.clear => 'SUNNY',
                                WeatherCondition.partlyCloudy => 'CLOUDY',
                                WeatherCondition.rain => 'RAINY',
                                _ => '',
                              },
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Draws the solid background
                Expanded(
                  child: Container(
                    color: switch (condition) {
                      WeatherCondition.clear => const Color(0xff4B90E2),
                      WeatherCondition.partlyCloudy => const Color(0xff628594),
                      WeatherCondition.rain => const Color(0xff57575C),
                      _ => const Color(0xff4B90E2),
                    },
                  ),
                )
              ],
            ),
            // This widget fixes an imperfection in the asset image
            if (condition == WeatherCondition.clear || condition == null) Positioned(
              top: imageHeight - 10,
              child: Container(
                height: 40,
                width: size.width,
                color: const Color(0xff4B90E2),
              ),
            ),
            // Draws the min, max, current, and 5 day forecast
            Positioned(
              top: imageHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      width: size.width - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TemperatureWidget(
                            temperature: min?.round() ?? -100,
                            label: 'min',
                          ),
                          TemperatureWidget(
                            temperature: current?.round() ?? -100,
                            label: 'Current',
                          ),
                          TemperatureWidget(
                            temperature: max?.round() ?? -100,
                            label: 'max',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 2,
                      width: size.width,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20, left: 20, right: 20),
                    child: SizedBox(
                      width: size.width - 40,
                      child: state.loading ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ) : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: page?.forecast.map((w) {
                          return ForecastWidget(
                            temperature: w.temperature.round(),
                            date: w.date,
                            condition: w.condition,
                          );
                        }).toList() ?? [
                          const Center(
                            child: Text('-'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
