import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:weather_app/domain/usecases/get_current_weather_by_location.dart';
import 'package:weather_app/domain/usecases/get_weather_forecast.dart';
import 'package:weather_app/domain/usecases/get_weather_forecast_by_location.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Weather
  // Bloc
  sl.registerFactory(() => WeatherBloc(
        getCurrentWeather: sl(),
        getCurrentWeatherByLocation: sl(),
        getWeatherForecast: sl(),
        getWeatherForecastByLocation: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetCurrentWeatherByLocation(sl()));
  sl.registerLazySingleton(() => GetWeatherForecast(sl()));
  sl.registerLazySingleton(() => GetWeatherForecastByLocation(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
}
