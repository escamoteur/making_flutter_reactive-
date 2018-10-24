// ignore_for_file: annotate_overrides

import "package:json_annotation/json_annotation.dart";

part "weather_in_cities.g.dart";

@JsonSerializable()
class WeatherInCities extends Object with _$WeatherInCitiesSerializerMixin {
  WeatherInCities(this.cnt, this.calctime, this.cod, this.cities);

  @JsonKey(name: 'cnt')
  final int cnt;

  @JsonKey(name: 'calctime')
  final double calctime;

  @JsonKey(name: 'cod')
  final int cod;

  @JsonKey(name: 'list')
  final List<City> cities;

  factory WeatherInCities.fromJson(Map<String, dynamic> json) =>
      _$WeatherInCitiesFromJson(json);
}

@JsonSerializable()
class City extends Object with _$CitySerializerMixin {
  City(this.id, this.coord, this.clouds, this.dt, this.name, this.main,
      this.rain, this.weather, this.wind);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'coord')
  final Coord coord;

  @JsonKey(name: 'clouds')
  final Clouds clouds;

  @JsonKey(name: 'dt')
  final int dt;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'main')
  final Main main;

  @JsonKey(name: 'rain')
  final Rain rain;

  @JsonKey(name: 'weather')
  final List<Weather> weather;

  @JsonKey(name: 'wind')
  final Wind wind;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@JsonSerializable()
class Coord extends Object with _$CoordSerializerMixin {
  Coord(this.lat, this.lon);

  @JsonKey(name: 'Lat')
  final double lat;

  @JsonKey(name: 'Lon')
  final double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

@JsonSerializable()
class Clouds extends Object with _$CloudsSerializerMixin {
  Clouds(this.today);

  @JsonKey(name: 'today')
  final int today;

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}

@JsonSerializable()
class Main extends Object with _$MainSerializerMixin {
  Main(this.seaLevel, this.humidity, this.grndLevel, this.pressure,
      this.tempMax, this.temp, this.tempMin);

  @JsonKey(name: 'sea_level', nullable: true)
  final double seaLevel;

  @JsonKey(name: 'humidity')
  final int humidity;

  @JsonKey(name: 'grnd_level', nullable: true)
  final double grndLevel;

  @JsonKey(name: 'pressure')
  final double pressure;

  @JsonKey(name: 'temp_max')
  final double tempMax;

  @JsonKey(name: 'temp')
  final double temp;

  @JsonKey(name: 'temp_min')
  final double tempMin;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@JsonSerializable()
class Rain extends Object with _$RainSerializerMixin {
  Rain(this.threeH);

  @JsonKey(name: '3h')
  final double threeH;

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
}

@JsonSerializable()
class Weather extends Object with _$WeatherSerializerMixin {
  Weather(this.icon, this.description, this.id, this.main);

  @JsonKey(name: 'icon')
  final String icon;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'main')
  final String main;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@JsonSerializable()
class Wind extends Object with _$WindSerializerMixin {
  Wind(this.deg, this.speed);

  @JsonKey(name: 'deg')
  final double deg;

  @JsonKey(name: 'speed')
  final double speed;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}
