import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_demo/keys.dart';
import 'package:flutter_weather_demo/service/weather_entry.dart';
import 'package:flutter_weather_demo/weather_icons.dart';


class WeatherListView extends StatelessWidget {
  
  final List<WeatherEntry> data;

 
  WeatherListView(this.data, {Key key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              key: AppKeys.cityList,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) =>
                               WeatherItem(entry: data[index]),
            );
   }
}

class WeatherItem extends StatelessWidget {
  final WeatherEntry entry;

  WeatherItem({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
                  leading: Icon(_weatherIdToIcon(entry.weatherId), size: 28.0,),
                  title: Text(entry.cityName),
                  subtitle: Text(entry.description, style: TextStyle(fontStyle: FontStyle.italic),),
                  trailing: Text('${entry.temperature.round()} °', style: TextStyle(fontSize: 20.0),
                  ),
    );
  }

  IconData _weatherIdToIcon(int weatherId) {
    switch (weatherId) {
      case 200:
      case 201:
      case 202:
      case 210:
      case 211:
      case 212:
      case 221:
      case 230:
      case 231:
      case 232:
        return WeatherIcons.clouds_flash_alt;
      case 300:
      case 301:
      case 302:
      case 310:
      case 311:
      case 312:
      case 313:
      case 314:
      case 321:
        return WeatherIcons.drizzle;
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
      case 511:
      case 520:
      case 521:
      case 522:
      case 531:
        return WeatherIcons.rain;
      case 600:
      case 601:
      case 611:
      case 612:
      case 615:
      case 616:
      case 620:
      case 621:
        return WeatherIcons.snow;
      case 602:
      case 622:
        return WeatherIcons.snow_heavy;
      case 701:
      case 711:
      case 721:
      case 731:
      case 741:
      case 751:
      case 761:
      case 762:
      case 771:
      case 781:
        return WeatherIcons.mist;
      case 800:
        return WeatherIcons.sun;
      case 801:
        return WeatherIcons.cloud_sun;
      case 802:
      case 803:
      case 804:
        return WeatherIcons.clouds;
      default:
        return WeatherIcons.sun;
    }
  }
}
