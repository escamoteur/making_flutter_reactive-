import 'dart:async';
import 'dart:convert';

import 'package:making_flutter_more_reactive/services/json/weather_in_cities.dart';
import 'package:making_flutter_more_reactive/services/weather_entry.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static String url =
      "http://api.openweathermap.org/data/2.5/box/city?bbox=5,47,14,54,20&appid=27ac337102cc4931c24ba0b50aca6bbd";

  final http.Client client;

  WeatherService(this.client);

  Future<List<WeatherEntry>> getWeatherEntriesForCity(String filter) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return new WeatherInCities.fromJson(
              json.decode(response.body) as Map<String, dynamic>)
          .cities
          .where((weatherInCity) =>
              filter == null ||
              filter.isEmpty ||
              weatherInCity.name.toUpperCase().startsWith(filter.toUpperCase()))
          .map((weatherInCity) => new WeatherEntry.from(weatherInCity))
          .toList();
    } else {
      throw new Exception('No cities found');
    }
  }
}
