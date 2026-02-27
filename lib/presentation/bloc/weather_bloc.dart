import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:weather_app/domain/usecases/get_current_weather_by_location.dart';
import 'package:weather_app/domain/usecases/get_weather_forecast.dart';
import 'package:weather_app/domain/usecases/get_weather_forecast_by_location.dart';
import 'package:weather_app/presentation/bloc/weather_event.dart';
import 'package:weather_app/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetCurrentWeatherByLocation getCurrentWeatherByLocation;
  final GetWeatherForecast getWeatherForecast;
  final GetWeatherForecastByLocation getWeatherForecastByLocation;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getCurrentWeatherByLocation,
    required this.getWeatherForecast,
    required this.getWeatherForecastByLocation,
  }) : super(WeatherEmpty()) {
    on<GetWeatherForCity>((event, emit) async {
      emit(WeatherLoading());

      final weatherResult = await getCurrentWeather(event.cityName);
      final forecastResult = await getWeatherForecast(event.cityName);

      weatherResult.fold(
        (failure) => emit(WeatherError(_mapFailureToMessage(failure))),
        (weather) {
          forecastResult.fold(
            (failure) => emit(WeatherError(_mapFailureToMessage(failure))),
            (forecast) => emit(WeatherLoaded(weather, forecast)),
          );
        },
      );
    });

    on<GetWeatherForLocation>((event, emit) async {
      emit(WeatherLoading());
      try {
        final position = await _determinePosition();

        final weatherResult = await getCurrentWeatherByLocation(
          position.latitude,
          position.longitude,
        );

        final forecastResult = await getWeatherForecastByLocation(
          position.latitude,
          position.longitude,
        );

        weatherResult.fold(
          (failure) => emit(WeatherError(_mapFailureToMessage(failure))),
          (weather) {
            forecastResult.fold(
              (failure) => emit(WeatherError(_mapFailureToMessage(failure))),
              (forecast) => emit(WeatherLoaded(weather, forecast)),
            );
          },
        );
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is ConnectionFailure) {
      return 'Failed to connect to the network';
    } else {
      return 'Unexpected Error';
    }
  }
}
