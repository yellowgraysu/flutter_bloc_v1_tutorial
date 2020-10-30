import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelsius;
  final double temperatureFarenhiet;

  Weather({
    @required this.cityName,
    @required this.temperatureCelsius,
    this.temperatureFarenhiet,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        this.cityName,
        this.temperatureCelsius,
        this.temperatureFarenhiet,
      ];
}
