import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';
import 'package:weather_app/presentation/widgets/glass_container.dart';

class HourlyForecastCard extends StatelessWidget {
  final HourlyForecast forecast;

  const HourlyForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: GlassContainer(
        borderRadius: 15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('HH:mm').format(forecast.time),
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              const SizedBox(height: 8),
              _getWeatherIcon(forecast.iconCode),
              const SizedBox(height: 8),
              Text(
                '${forecast.temperature.round()}°',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getWeatherIcon(String iconCode) {
    return Image.network(
      'https://openweathermap.org/img/wn/$iconCode@2x.png',
      width: 40,
      height: 40,
    );
  }
}
