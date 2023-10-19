import 'package:flutter/material.dart';
import 'package:weather_app/dependencies.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/widgets/widgets.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {

  final GetWeatherData _getWeatherData = locator.get<GetWeatherData>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WeatherLayoutWidget(),
    );
  }

  _fetchWeatherData() async {
    await _getWeatherData.execute(null);
  }
}
