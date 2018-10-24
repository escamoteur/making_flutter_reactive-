// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_in_cities.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

WeatherInCities _$WeatherInCitiesFromJson(Map<String, dynamic> json) =>
    new WeatherInCities(
        json['cnt'] as int,
        (json['calctime'] as num)?.toDouble(),
        json['cod'] as int,
        (json['list'] as List)
            ?.map((e) =>
                e == null ? null : new City.fromJson(e as Map<String, dynamic>))
            ?.toList());

abstract class _$WeatherInCitiesSerializerMixin {
  int get cnt;

  double get calctime;

  int get cod;

  List<City> get cities;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cnt': cnt,
        'calctime': calctime,
        'cod': cod,
        'list': cities
      };
}

City _$CityFromJson(Map<String, dynamic> json) => new City(
    json['id'] as int,
    json['coord'] == null
        ? null
        : new Coord.fromJson(json['coord'] as Map<String, dynamic>),
    json['clouds'] == null
        ? null
        : new Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    json['dt'] as int,
    json['name'] as String,
    json['main'] == null
        ? null
        : new Main.fromJson(json['main'] as Map<String, dynamic>),
    json['rain'] == null
        ? null
        : new Rain.fromJson(json['rain'] as Map<String, dynamic>),
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : new Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['wind'] == null
        ? null
        : new Wind.fromJson(json['wind'] as Map<String, dynamic>));

abstract class _$CitySerializerMixin {
  int get id;

  Coord get coord;

  Clouds get clouds;

  int get dt;

  String get name;

  Main get main;

  Rain get rain;

  List<Weather> get weather;

  Wind get wind;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'coord': coord,
        'clouds': clouds,
        'dt': dt,
        'name': name,
        'main': main,
        'rain': rain,
        'weather': weather,
        'wind': wind
      };
}

Coord _$CoordFromJson(Map<String, dynamic> json) => new Coord(
    (json['Lat'] as num)?.toDouble(), (json['Lon'] as num)?.toDouble());

abstract class _$CoordSerializerMixin {
  double get lat;

  double get lon;

  Map<String, dynamic> toJson() => <String, dynamic>{'Lat': lat, 'Lon': lon};
}

Clouds _$CloudsFromJson(Map<String, dynamic> json) =>
    new Clouds(json['today'] as int);

abstract class _$CloudsSerializerMixin {
  int get today;

  Map<String, dynamic> toJson() => <String, dynamic>{'today': today};
}

Main _$MainFromJson(Map<String, dynamic> json) => new Main(
    (json['sea_level'] as num)?.toDouble(),
    json['humidity'] as int,
    (json['grnd_level'] as num)?.toDouble(),
    (json['pressure'] as num)?.toDouble(),
    (json['temp_max'] as num)?.toDouble(),
    (json['temp'] as num)?.toDouble(),
    (json['temp_min'] as num)?.toDouble());

abstract class _$MainSerializerMixin {
  double get seaLevel;

  int get humidity;

  double get grndLevel;

  double get pressure;

  double get tempMax;

  double get temp;

  double get tempMin;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sea_level': seaLevel,
        'humidity': humidity,
        'grnd_level': grndLevel,
        'pressure': pressure,
        'temp_max': tempMax,
        'temp': temp,
        'temp_min': tempMin
      };
}

Rain _$RainFromJson(Map<String, dynamic> json) =>
    new Rain((json['3h'] as num)?.toDouble());

abstract class _$RainSerializerMixin {
  double get threeH;

  Map<String, dynamic> toJson() => <String, dynamic>{'3h': threeH};
}

Weather _$WeatherFromJson(Map<String, dynamic> json) => new Weather(
    json['icon'] as String,
    json['description'] as String,
    json['id'] as int,
    json['main'] as String);

abstract class _$WeatherSerializerMixin {
  String get icon;

  String get description;

  int get id;

  String get main;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'icon': icon,
        'description': description,
        'id': id,
        'main': main
      };
}

Wind _$WindFromJson(Map<String, dynamic> json) => new Wind(
    (json['deg'] as num)?.toDouble(), (json['speed'] as num)?.toDouble());

abstract class _$WindSerializerMixin {
  double get deg;

  double get speed;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'deg': deg, 'speed': speed};
}
