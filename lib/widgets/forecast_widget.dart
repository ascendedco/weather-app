import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/domain.dart';

class ForecastWidget extends StatelessWidget {

  final int temperature;
  final DateTime date;
  final WeatherCondition condition;

  final DateFormat _dateFormat = DateFormat('EEEE');

  ForecastWidget({
    super.key,
    required this.temperature,
    required this.date,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _dateFormat.format(date),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              Text(
                '$temperature\u00B0',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Center(
            child: Image.asset(
              switch (condition) {
                WeatherCondition.clear => 'assets/icons/clear.png',
                WeatherCondition.partlyCloudy => 'assets/icons/partlysunny.png',
                WeatherCondition.rain => 'assets/icons/rain.png',
                WeatherCondition.unknown => 'assets/icons/clear.png',
              },
              width: 38,
              height: 38,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}