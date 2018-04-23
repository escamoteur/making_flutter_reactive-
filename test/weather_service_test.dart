
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:making_flutter_more_reactive/service/weather_service.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('WeatherService', () {
    test('should return all items when empty filter provided', () async {
      final client = new MockClient();
      final service = new WeatherService(client);
      when(client.get(WeatherService.url))
          .thenAnswer((_) async => new http.Response(responseBody, 200));

      final entries = await service.getWeatherEntriesForCity('');

      expect(entries.length, 3);
    });

    test('should return all items when null filter provided', () async {
      final client = new MockClient();
      final service = new WeatherService(client);
      when(client.get(WeatherService.url))
          .thenAnswer((_) async => new http.Response(responseBody, 200));

      final entries = await service.getWeatherEntriesForCity(null);

      expect(entries.length, 3);
    });

    test('should filter the entries when given a city name', () async {
      final client = new MockClient();
      final service = new WeatherService(client);
      when(client.get(WeatherService.url))
          .thenAnswer((_) async => new http.Response(responseBody, 200));

      final entries = await service.getWeatherEntriesForCity('Dole');

      expect(entries.length, 1);
    });

    test('should throw an exception when the response is not 200', () async {
      final client = new MockClient();
      final service = new WeatherService(client);
      when(client.get(WeatherService.url))
          .thenAnswer((_) async => new http.Response('Error', 404));

      expect(service.getWeatherEntriesForCity('Dole'), throwsException);
    });

    test('should throw an exception when the json is malformed', () async {
      final client = new MockClient();
      final service = new WeatherService(client);
      when(client.get(WeatherService.url))
          .thenAnswer((_) async => new http.Response('p[2p[1p[ppadsdaf', 200));

      expect(service.getWeatherEntriesForCity('Dole'), throwsException);
    });
  });
}

final responseBody = '''{
    "cod": 200,
    "calctime": 1.417389621,
    "cnt": 1284,
    "list": [
        {
            "id": 3021263,
            "dt": 1523570501,
            "name": "Dole",
            "coord": {
                "Lat": 47.099998,
                "Lon": 5.5
            },
            "main": {
                "temp": 10.46,
                "temp_min": 10,
                "temp_max": 11,
                "pressure": 1002,
                "humidity": 81
            },
            "wind": {
                "speed": 1,
                "deg": 200
            },
            "rain": null,
            "snow": null,
            "clouds": {
                "today": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ]
        },
        {
            "id": 3025496,
            "dt": 1523570527,
            "name": "Chenove",
            "coord": {
                "Lat": 47.293228,
                "Lon": 5.00457
            },
            "main": {
                "temp": 10.54,
                "temp_min": 10,
                "temp_max": 11,
                "pressure": 1002,
                "humidity": 76
            },
            "wind": {
                "speed": 1.5,
                "deg": 0
            },
            "rain": null,
            "snow": null,
            "clouds": {
                "today": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ]
        },
        {
            "id": 3021372,
            "dt": 1523567078,
            "name": "Dijon",
            "coord": {
                "Lat": 47.316669,
                "Lon": 5.01667
            },
            "main": {
                "temp": 10.54,
                "temp_min": 10,
                "temp_max": 11,
                "pressure": 1001,
                "humidity": 76
            },
            "wind": {
                "speed": 1.5,
                "deg": 260
            },
            "rain": null,
            "snow": null,
            "clouds": {
                "today": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01n"
                }
            ]
        }
    ]
}''';
