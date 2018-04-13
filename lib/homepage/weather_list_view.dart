import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_demo/keys.dart';
import 'package:flutter_weather_demo/model_provider.dart';
import 'package:flutter_weather_demo/service/weather_entry.dart';
import 'package:flutter_weather_demo/weather_icons.dart';

class WeatherListView extends StatelessWidget {
  WeatherListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // StreamBuilder rebuilds its subtree on every item the stream issues
    return new StreamBuilder<List<WeatherEntry>>(
      // Fetch list of cities from the HomePageModel, which is passed down
      // the tree by the ModelProvider InheritedWidget,
      stream: ModelProvider.of(context).updateWeatherCommand.results,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return new ListView.builder(
              key: AppKeys.cityList,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) =>
                  new WeatherItem(entry: snapshot.data[index]),
            );
          } else {
            return new Text('No Items', key: AppKeys.noItems);
          }
        } else if (snapshot.hasError) {
          // Todo: Figure out a good way to handle errors
          return new Text('Error', key: AppKeys.loadingError);
        } else {
          return new Container(key: AppKeys.empty);
        }
      },
    );
  }
}

class WeatherItem extends StatelessWidget {
  final WeatherEntry entry;

  WeatherItem({Key key, @required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Icon(
        _weatherIdToIcon(entry.weatherId),
        size: 28.0,
      ),
      title: new Text(entry.cityName),
      subtitle: new Text(
        entry.description,
        style: new TextStyle(fontStyle: FontStyle.italic),
      ),
      trailing: new Text(
        '${entry.temperature.round()} °',
        style: new TextStyle(fontSize: 20.0),
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
