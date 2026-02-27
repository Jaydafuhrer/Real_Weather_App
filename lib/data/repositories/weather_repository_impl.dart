import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final weather = await remoteDataSource.getCurrentWeather(cityName);
      return Right(weather);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Weather>> getCurrentWeatherByLocation(
      double lat, double lon) async {
    try {
      final result =
          await remoteDataSource.getCurrentWeatherByLocation(lat, lon);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherForecast>> getForecast(String cityName) async {
    try {
      final result = await remoteDataSource.getForecast(cityName);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherForecast>> getForecastByLocation(
      double lat, double lon) async {
    try {
      final result = await remoteDataSource.getForecastByLocation(lat, lon);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
