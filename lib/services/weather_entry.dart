import 'json/weather_in_cities.dart';

class WeatherEntry {
  final String cityName;
  final double wind;
  final double temperature;
  final String description;
  final int weatherId;

  WeatherEntry(
    this.cityName,
    this.wind,
    this.temperature,
    this.description,
    this.weatherId,
  );

  WeatherEntry.from(City city)
      : cityName = city.name,
        wind = city.wind.speed,
        temperature = city.main.temp,
        description = city.weather[0]?.description,
        weatherId = city.weather[0].id;

   @override
   bool operator == (other) {
     return cityName == other.cityName;
   } 

   @override
   int get hashCode => cityName.hashCode;
}
