import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final WeatherForecast forecast;

  const WeatherLoaded(this.weather, this.forecast);

  @override
  List<Object?> get props => [weather, forecast];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
