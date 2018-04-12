import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'json/weather_in_cities.dart';
import 'weather_entry.dart';

class WeatherService {

  static String url = "http://api.openweathermap.org/data/2.5/box/city?bbox=5,47,14,54,20&appid=27ac337102cc4931c24ba0b50aca6bbd";  
      

  
  static Observable<List<WeatherEntry>> getWeatherEntriesForCity(String cityNameFilter)
  {
      var httpStream = new Observable(http.get(url).asStream());

      return  httpStream
              .where((data) => data.statusCode == 200)  // only continue if valid response
                .map( (data) // convert JSON result in ModelObject
                {
                      return new WeatherInCities.fromJson(json.decode(data.body)).Cities
                        .where( (weatherInCity) =>  cityNameFilter.isEmpty || weatherInCity.Name.toUpperCase().startsWith(cityNameFilter.toUpperCase()))
                          .map((weatherInCity) => new WeatherEntry(weatherInCity) )
                            .toList();
                });
  
  }
}