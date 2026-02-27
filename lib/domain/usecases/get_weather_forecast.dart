import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetWeatherForecast {
  final WeatherRepository repository;

  GetWeatherForecast(this.repository);

  Future<Either<Failure, WeatherForecast>> call(String cityName) async {
    return await repository.getForecast(cityName);
  }
}
