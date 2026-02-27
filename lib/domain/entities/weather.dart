import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;
  final double humidity;
  final double windSpeed;
  final String countryCode;

  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int visibility;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.visibility,
    required this.countryCode,
  });

  @override
  List<Object?> get props => [
        cityName,
        temperature,
        description,
        iconCode,
        humidity,
        windSpeed,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        visibility,
      ];
}
