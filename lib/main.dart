import 'package:flutter/material.dart';
import 'package:making_flutter_more_reactive/homepage/homepage.dart';
import 'package:making_flutter_more_reactive/homepage/homepage_model.dart';
import 'package:making_flutter_more_reactive/model_provider.dart';
import 'package:making_flutter_more_reactive/service/weather_service.dart';
import 'package:http/http.dart' as http;

void main() {
  final weatherService = new WeatherService(new http.Client());
  final homePageModel = new HomePageModel(weatherService);

  runApp(new MyApp(
    model: homePageModel,
  ));
}

class MyApp extends StatelessWidget {
  final HomePageModel model;

  const MyApp({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ModelProvider(
      model: model,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData.dark().copyWith(
          disabledColor: Colors.white12,
          primaryColor: new Color(0xFF1C262A),
          buttonColor: new Color(0xFF1C262A),
          accentColor: new Color(0xFFA7D9D5),
          scaffoldBackgroundColor: new Color.fromRGBO(38, 50, 56, 1.0),
        ),
        home: new HomePage(),
      ),
    );
  }
}
