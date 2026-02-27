import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
  Future<Either<Failure, Weather>> getCurrentWeatherByLocation(
      double lat, double lon);
  Future<Either<Failure, WeatherForecast>> getForecast(String cityName);
  Future<Either<Failure, WeatherForecast>> getForecastByLocation(
      double lat, double lon);
}
