import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {

  final int temperature;
  final String label;

  const TemperatureWidget({
    super.key,
    required this.temperature,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          temperature != -100 ?
            '$temperature\u00B0' :
            '-',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}