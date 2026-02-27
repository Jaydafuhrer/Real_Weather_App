import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';
import 'package:weather_app/presentation/widgets/initial_message.dart';
import 'package:weather_app/presentation/widgets/loading_widget.dart';
import 'package:weather_app/presentation/widgets/weather_display.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Weather Today',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(247, 212, 181, 1),
              Color.fromRGBO(254, 227, 199, 1),
              Color.fromRGBO(254, 235, 207, 1),
              Color.fromRGBO(254, 229, 202, 1),
              Color.fromRGBO(253, 195, 141, 1),
              Color.fromRGBO(253, 195, 150, 1),
              Color.fromRGBO(253, 189, 129, 1),
              Color.fromRGBO(254, 189, 130, 1),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Search city...',
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.my_location,
                              color: Colors.black),
                          onPressed: () {
                            context
                                .read<WeatherBloc>()
                                .add(const GetWeatherForLocation());
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.08),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<WeatherBloc>()
                              .add(GetWeatherForCity(value));
                        }
                      },
                    ),
                  ),

                  // Weather content
                  Expanded(
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherLoading) {
                          return const LoadingWidget();
                        } else if (state is WeatherLoaded) {
                          // Pass weather and forecast to the updated WeatherDisplay with flag
                          return WeatherDisplay(
                            weather: state.weather, // must include countryCode
                            forecast: state.forecast,
                          );
                        } else if (state is WeatherError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return const InitialMessage();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
