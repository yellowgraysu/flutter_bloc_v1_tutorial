import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_v1_tutorial/data/weather_repository.dart';
import 'package:flutter_bloc_v1_tutorial/page/weather_search_page.dart';

import 'bloc/weather_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var navigatorState;

    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(),
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: WillPopScope(
          onWillPop: () async {
            if(navigatorState?.canPop() ?? false){
              navigatorState.pop();
              return false;
            }
            return true;
          },
          child: Navigator(
            onGenerateRoute: (settings) =>
                MaterialPageRoute(builder: (innerContext) {
                  navigatorState = Navigator.of(innerContext);
                  return WeatherSearchPage();
                }),
          ),
        ),
      ),
    );
  }
}
