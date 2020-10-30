import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/data/model/weather.dart';
import 'package:flutter_bloc_v1_tutorial/bloc/weather_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/page/weather_detail_page.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return _buildInitialInput();
              } else if (state is WeatherLoading) {
                return _buildLoading();
              } else if (state is WeatherLoad) {
                return _buildColumnWithData(context, state.weather);
              } else if (state is WeatherError) {
                return _buildInitialInput();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInitialInput() => Center(child: CityInputField());

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildColumnWithData(BuildContext context, Weather weather) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 50),
          ),
          Text(
            '${weather.temperatureCelsius.toStringAsFixed(1)} °C',
            style: TextStyle(fontSize: 50),
          ),
          RaisedButton(
              child: Text('See Detail'),
              color: Colors.lightBlue[100],
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        BlocProvider.value(
                          value: BlocProvider.of<WeatherBloc>(context),
                          child: WeatherDetailPage(masterWeather: weather),
                        )));
              }),
          CityInputField(),
        ],
      );
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => submitCityName(context, value),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: "Enter a City",
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    // Get the Bloc using the BlocProvider
    // False positive lint warning, safe to ignore until it gets fixed...
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    // Initiate getting the weather
    weatherBloc.add(GetWeather(cityName));
  }
}

