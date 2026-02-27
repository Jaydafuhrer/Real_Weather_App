import 'package:weather_app/domain/entities/weather_forecast.dart';

class WeatherForecastModel extends WeatherForecast {
  const WeatherForecastModel({
    required super.hourly,
    required super.daily,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    final hourlyList = (json['list'] as List)
        .take(8) // Next 24 hours (3-hour intervals)
        .map((item) => HourlyForecastModel.fromJson(item))
        .toList();

    // Grouping by day for daily forecast (simplified approach)
    final dailyList = <DailyForecast>[];
    final seenDates = <String>{};
    for (var item in json['list']) {
      final date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      final dateString = "${date.year}-${date.month}-${date.day}";
      if (!seenDates.contains(dateString)) {
        seenDates.add(dateString);
        dailyList.add(DailyForecastModel.fromJson(item));
      }
      if (dailyList.length >= 7) break;
    }

    return WeatherForecastModel(
      hourly: hourlyList,
      daily: dailyList.cast<DailyForecastModel>(),
    );
  }
}

class HourlyForecastModel extends HourlyForecast {
  const HourlyForecastModel({
    required super.time,
    required super.temperature,
    required super.description,
    required super.iconCode,
  });

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) {
    return HourlyForecastModel(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      iconCode: json['weather'][0]['icon'] ?? '',
    );
  }
}

class DailyForecastModel extends DailyForecast {
  const DailyForecastModel({
    required super.date,
    required super.minTemp,
    required super.maxTemp,
    required super.description,
    required super.iconCode,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    return DailyForecastModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      minTemp: (json['main']['temp_min'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      iconCode: json['weather'][0]['icon'] ?? '',
    );
  }
}
