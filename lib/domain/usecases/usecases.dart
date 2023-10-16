library usecases;

export 'get_forecast.dart';
export 'get_location.dart';
export 'get_weather.dart';
export 'get_weather_data.dart';

abstract class UseCaseFuture<Input, Output> {
  Future<Output> execute(Input input);
}