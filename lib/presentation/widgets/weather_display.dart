import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/entities/weather_forecast.dart';
import 'package:weather_app/presentation/widgets/daily_forecast_tile.dart';
import 'package:weather_app/presentation/widgets/glass_container.dart';
import 'package:weather_app/presentation/widgets/hourly_forecast_card.dart';
import 'package:weather_app/presentation/widgets/weather_detail_grid.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  final WeatherForecast forecast;

  const WeatherDisplay(
      {super.key, required this.weather, required this.forecast});

  // Convert ISO country code to flag emoji
  String countryCodeToEmoji(String countryCode) {
    return countryCode
        .toUpperCase()
        .runes
        .map((e) => String.fromCharCode(e + 127397))
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return _buildWideLayout();
        } else {
          return _buildNarrowLayout();
        }
      },
    );
  }

  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCurrentWeatherHeader(),
          const SizedBox(height: 30),
          _buildHourlyForecast(),
          const SizedBox(height: 20),
          WeatherDetailGrid(weather: weather),
          const SizedBox(height: 20),
          _buildDailyForecast(),
        ],
      ),
    );
  }

  Widget _buildWideLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Current Weather
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildCurrentWeatherHeader(),
                const SizedBox(height: 40),
                WeatherDetailGrid(weather: weather),
              ],
            ),
          ),
          const SizedBox(width: 32),
          // Right Side: Forecasts
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHourlyForecast(),
                const SizedBox(height: 32),
                _buildDailyForecast(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentWeatherHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(width: 8),
            Text(
              countryCodeToEmoji(weather.countryCode),
              style: const TextStyle(fontSize: 34),
            ).animate().fadeIn(duration: 600.ms),
          ],
        ),
        const SizedBox(height: 8),
        // Temperature
        Text(
          textAlign: TextAlign.center,
          '${weather.temperature.round()}°',
          style: const TextStyle(
              fontSize: 90, fontWeight: FontWeight.w200, color: Colors.black),
        ).animate().fadeIn(delay: 200.ms).scale(),
        const SizedBox(height: 8),
        // Description
        Text(
          textAlign: TextAlign.center,
          weather.description.toUpperCase(),
          style: const TextStyle(
              fontSize: 18, color: Colors.black, letterSpacing: 2),
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 8),
        // High / Low
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('H:${weather.tempMax.round()}°',
                style: const TextStyle(color: Colors.black, fontSize: 16)),
            const SizedBox(width: 10),
            Text('L:${weather.tempMin.round()}°',
                style: const TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ).animate().fadeIn(delay: 600.ms),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 12),
          child: Text(
            'HOURLY FORECAST',
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: forecast.hourly.length,
            itemBuilder: (context, index) {
              return HourlyForecastCard(forecast: forecast.hourly[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDailyForecast() {
    return GlassContainer(
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.white54, size: 16),
                SizedBox(width: 8),
                Text(
                  '7-DAY FORECAST',
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ],
            ),
          ),
          Column(
            children: forecast.daily
                .map((day) => DailyForecastTile(forecast: day))
                .toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
