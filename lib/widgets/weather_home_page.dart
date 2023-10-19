import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/dependencies.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/state/state.dart';
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
    return Scaffold(
      body: Consumer<WeatherProvider>(
        builder: (context, value, child) {
          final WeatherState state = value.state;
          return WeatherLayoutWidget(
            page: state.pages.firstOrNull,
            loading: state.loading,
          );
        },
      ),
    );
  }

  _fetchWeatherData() async {
    try {
      await _getWeatherData.execute(null);
    }
    catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.toString()),
        ),
      );
    }
  }
}
