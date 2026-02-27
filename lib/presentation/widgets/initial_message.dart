import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InitialMessage extends StatelessWidget {
  const InitialMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_queue, size: 100, color: Colors.black)
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .moveY(
                  begin: -10,
                  end: 10,
                  duration: 2.seconds,
                  curve: Curves.easeInOut),
          const SizedBox(height: 24),
          const Text(
            'Discover the Weather',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w200),
          ).animate().fadeIn(duration: 800.ms),
          const SizedBox(height: 8),
          const Text(
            'Search for a city or use your location',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}
