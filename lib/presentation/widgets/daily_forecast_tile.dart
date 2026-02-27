import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';

class DailyForecastTile extends StatelessWidget {
  final DailyForecast forecast;

  const DailyForecastTile({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              _getDay(forecast.date),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Expanded(
            child: _getWeatherIcon(forecast.iconCode),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${forecast.maxTemp.round()}°',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                Text(
                  '${forecast.minTemp.round()}°',
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDay(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Today';
    }
    return DateFormat('EEEE').format(date);
  }

  Widget _getWeatherIcon(String iconCode) {
    return Image.network(
      'https://openweathermap.org/img/wn/$iconCode.png',
      width: 30,
      height: 30,
    );
  }
}
