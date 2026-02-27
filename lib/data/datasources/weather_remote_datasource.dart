import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/data/models/weather_forecast_model.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<WeatherModel> getCurrentWeatherByLocation(double lat, double lon);
  Future<WeatherForecastModel> getForecast(String cityName);
  Future<WeatherForecastModel> getForecastByLocation(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  // Helper method to handle GET requests
  Future<Map<String, dynamic>> _getJson(Uri url) async {
    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        // Try to decode error message from OpenWeatherMap
        final errorJson = json.decode(response.body);
        final message = errorJson['message'] ?? 'Unknown server error';
        throw ServerException(message: message);
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Network error or invalid format: $e');
    }
  }

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final url = Uri.parse(
      "${dotenv.env['BASE_URL']}/weather?q=$cityName&appid=${dotenv.env['API_KEY']}&units=metric",
    );
    final jsonData = await _getJson(url);
    return WeatherModel.fromJson(jsonData);
  }

  @override
  Future<WeatherModel> getCurrentWeatherByLocation(
      double lat, double lon) async {
    final url = Uri.parse(
      '${dotenv.env['BASE_URL']}/weather?lat=$lat&lon=$lon&appid=${dotenv.env['API_KEY']}&units=metric',
    );
    final jsonData = await _getJson(url);
    return WeatherModel.fromJson(jsonData);
  }

  @override
  Future<WeatherForecastModel> getForecast(String cityName) async {
    final url = Uri.parse(
      '${dotenv.env['BASE_URL']}/forecast?q=$cityName&appid=${dotenv.env['API_KEY']}&units=metric',
    );
    final jsonData = await _getJson(url);
    return WeatherForecastModel.fromJson(jsonData);
  }

  @override
  Future<WeatherForecastModel> getForecastByLocation(
      double lat, double lon) async {
    final url = Uri.parse(
      '${dotenv.env['BASE_URL']}/forecast?lat=$lat&lon=$lon&appid=${dotenv.env['API_KEY']}&units=metric',
    );
    final jsonData = await _getJson(url);
    return WeatherForecastModel.fromJson(jsonData);
  }
}
