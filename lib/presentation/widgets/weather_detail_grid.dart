import 'package:flutter/material.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/widgets/glass_container.dart';

class WeatherDetailGrid extends StatelessWidget {
  final Weather weather;

  const WeatherDetailGrid({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      padding: const EdgeInsets.all(16),
      children: [
        _buildDetailItem(
            'FEELS LIKE', '${weather.feelsLike.round()}°', Icons.thermostat),
        _buildDetailItem(
            'WIND', '${weather.windSpeed.round()} km/h', Icons.air),
        _buildDetailItem(
            'HUMIDITY', '${weather.humidity.round()}%', Icons.water_drop),
        _buildDetailItem(
            'VISIBILITY',
            '${(weather.visibility / 1000).toStringAsFixed(1)} km',
            Icons.visibility),
        _buildDetailItem('PRESSURE', '${weather.pressure} hPa', Icons.speed),
        _buildDetailItem(
            'HUMIDITY', '${weather.humidity.round()}%', Icons.waves),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return GlassContainer(
      borderRadius: 15,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.black, size: 16),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
