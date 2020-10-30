part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String cityName;

  const GetWeather(this.cityName);

  @override
  List<Object> get props => [this.cityName];
}

class GetDetailWeather extends WeatherEvent {
  final String cityName;

  const GetDetailWeather(this.cityName);

  @override
  List<Object> get props => [this.cityName];
}