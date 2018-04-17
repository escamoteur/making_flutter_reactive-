import 'dart:async';

import 'package:flutter_weather_demo/homepage/homepage_model.dart';
import 'package:flutter_weather_demo/service/weather_entry.dart';
import 'package:flutter_weather_demo/service/weather_service.dart';
import 'package:mockito/mockito.dart';
import 'package:quiver/testing/async.dart';
import 'package:test/test.dart';

class MockService extends Mock implements WeatherService {}

main() {
  group('HomePageModel', () {
    test('should immediately fetch the weather with an empty string when the HomePageModel gets created', () async {
      final service = new MockService();
      final model = new HomePageModel(service); // ignore: unused_local_variable

      when(service.getWeatherEntriesForCity(typed(any)))
          .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

      expect(model.updateWeatherCommand.results, emits([]));
    });

    test('should fetch with filter', () async {
      final service = new MockService();
      final model = new HomePageModel(service);
      final future = new Future.sync(() => <WeatherEntry>[]);

      when(service.getWeatherEntriesForCity(typed(any)))
          .thenAnswer((_) => future);

      //updateWeatherCommand call on creation of the HomePageModel
      expect(model.updateWeatherCommand.results, emits([]));

      model.updateWeatherCommand('A');
      expect(model.updateWeatherCommand.results, emits(['A']));
    });

    test('should not fetch if switch is off', () async {
      final service = new MockService();
      final model = new HomePageModel(service);

      when(service.getWeatherEntriesForCity(typed(any)))
          .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

      model.switchChangedCommand(false);
      model.updateWeatherCommand('A');
      verifyNever(service.getWeatherEntriesForCity('A'));
    });

    test('should filter after the user stops typing for 500ms', () async {
      // Use FakeAsync from the Quiver package to simulate time
      new FakeAsync().run((time) {
        final service = new MockService();
        final model = new HomePageModel(service);

        when(service.getWeatherEntriesForCity(typed(any)))
            .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

        model.textChangedCommand('A');
        time.elapse(new Duration(milliseconds: 1000));

        verify(service.getWeatherEntriesForCity('A'));
      });
    });

    test('should not search if the user has not paused for 500ms', () async {
      // Use FakeAsync from the Quiver package to simulate time
      new FakeAsync().run((time) {
        final service = new MockService();
        final model = new HomePageModel(service);

        when(service.getWeatherEntriesForCity(typed(any)))
            .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

        model.textChangedCommand('A');
        time.elapse(new Duration(milliseconds: 100));

        verifyNever(service.getWeatherEntriesForCity('A'));
      });
    });
  });
}
