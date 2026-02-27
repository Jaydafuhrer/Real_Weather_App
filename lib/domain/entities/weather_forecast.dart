import 'package:equatable/equatable.dart';

class WeatherForecast extends Equatable {
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  const WeatherForecast({
    required this.hourly,
    required this.daily,
  });

  @override
  List<Object?> get props => [hourly, daily];
}

class HourlyForecast extends Equatable {
  final DateTime time;
  final double temperature;
  final String description;
  final String iconCode;

  const HourlyForecast({
    required this.time,
    required this.temperature,
    required this.description,
    required this.iconCode,
  });

  @override
  List<Object?> get props => [time, temperature, description, iconCode];
}

class DailyForecast extends Equatable {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String iconCode;

  const DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.iconCode,
  });

  @override
  List<Object?> get props => [date, minTemp, maxTemp, description, iconCode];
}
