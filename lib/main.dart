import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/dependencies.dart';
import 'package:weather_app/domain/domain.dart';
import 'package:weather_app/state/state.dart';
import 'package:weather_app/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  registerDependencies();
  await initDependencies();

  final weatherState = locator.get<WeatherStateManager>();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => weatherState as WeatherProvider),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const WeatherHomePage(),
    );
  }
}
