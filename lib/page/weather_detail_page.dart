import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/bloc/weather_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/data/model/weather.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;

  WeatherDetailPage({@required this.masterWeather, Key key}) : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoad) {
              return _buildColumnWithData(context, state.weather);
            }
            return Container();
          },
        )
      ),
    );
  }

  Widget _buildColumnWithData(context, weather)=>
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        weather.cityName,
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
      Text(
        '${weather.temperatureCelsius?.toStringAsFixed(1)} °C',
        style: TextStyle(fontSize: 70),
      ),
      Text(
        '${weather.temperatureFarenhiet?.toStringAsFixed(1)} °F',
        style: TextStyle(fontSize: 70),
      ),
    ],
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
      ..add(GetDetailWeather(widget.masterWeather.cityName));
  }
}