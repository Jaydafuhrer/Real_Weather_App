import 'package:weather_app/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.countryCode,
    required super.temperature,
    required super.description,
    required super.iconCode,
    required super.humidity,
    required super.windSpeed,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.visibility,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final sys = json['sys'] as Map<String, dynamic>?;

    return WeatherModel(
      cityName: json['name'] ?? '',
      countryCode: sys?['country'] ?? 'US', // safe null check
      temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
      description:
          (json['weather'] != null && (json['weather'] as List).isNotEmpty)
              ? json['weather'][0]['description'] ?? ''
              : '',
      iconCode:
          (json['weather'] != null && (json['weather'] as List).isNotEmpty)
              ? json['weather'][0]['icon'] ?? ''
              : '',
      humidity: (json['main']?['humidity'] as num?)?.toDouble() ?? 0.0,
      windSpeed: (json['wind']?['speed'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['main']?['feels_like'] as num?)?.toDouble() ?? 0.0,
      tempMin: (json['main']?['temp_min'] as num?)?.toDouble() ?? 0.0,
      tempMax: (json['main']?['temp_max'] as num?)?.toDouble() ?? 0.0,
      pressure: json['main']?['pressure'] as int? ?? 0,
      visibility: json['visibility'] as int? ?? 0,
    );
  }
}
