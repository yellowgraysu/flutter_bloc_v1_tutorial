import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_v1_tutorial/data/model/weather.dart';
import 'package:flutter_bloc_v1_tutorial/data/weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // Emitting a state from the asynchronous generator
    yield WeatherLoading();
    // Branching the executed logic by checking the event type
    if (event is GetWeather) {
      // Emit either Loaded or Error
      try {
        final weather = await repository.fetchWeather(event.cityName);
        yield WeatherLoad(weather);
      } on NetworkError {
        yield WeatherError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is GetDetailWeather) {
      // Code duplication 😢 to keep the code simple for the tutorial...
      try {
        final weather = await repository.fetchDetailedWeather(event.cityName);
        yield WeatherLoad(weather);
      } on NetworkError {
        yield WeatherError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
