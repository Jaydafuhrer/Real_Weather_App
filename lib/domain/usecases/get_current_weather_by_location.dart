import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetCurrentWeatherByLocation {
  final WeatherRepository repository;

  GetCurrentWeatherByLocation(this.repository);

  Future<Either<Failure, Weather>> call(double lat, double lon) async {
    return await repository.getCurrentWeatherByLocation(lat, lon);
  }
}
