import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetWeatherForecastByLocation {
  final WeatherRepository repository;

  GetWeatherForecastByLocation(this.repository);

  Future<Either<Failure, WeatherForecast>> call(double lat, double lon) async {
    return await repository.getForecastByLocation(lat, lon);
  }
}
