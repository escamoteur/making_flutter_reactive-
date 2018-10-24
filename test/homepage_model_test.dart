import 'dart:async';

import 'package:making_flutter_more_reactive/managers/app_manager.dart';
import 'package:making_flutter_more_reactive/service_locator.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/src/mock.dart';
import 'package:quiver/testing/async.dart';

import 'package:making_flutter_more_reactive/services/weather_entry.dart';
import 'package:making_flutter_more_reactive/services/weather_service.dart';
import 'package:test/test.dart';

class MockService extends Mock implements WeatherService {}


main() {
  sl.allowReassignment = true;

  group('HomePageModel', () {
    test('should immediately fetch the weather with an empty string when the HomePageModel gets created', () async {
      final service = new MockService();

      sl.registerSingleton<WeatherService>(service);
      final model = new AppManager(); // ignore: unused_local_variable

      when(service.getWeatherEntriesForCity(typed(any as ArgMatcher)))
          .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

      expect(model.updateWeatherCommand.results, emits([]));
    });



    test('should not fetch if switch is off', () async {
      final service = new MockService();
      sl.registerSingleton<WeatherService>(service);
      final manager = new AppManager();

      when(service.getWeatherEntriesForCity(typed(any as ArgMatcher)))
          .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

      manager.switchChangedCommand(false);
      manager.updateWeatherCommand('A');
      verifyNever(service.getWeatherEntriesForCity('A'));
    });

    test('should filter after the user stops typing for 500ms', () async {
      // Use FakeAsync from the Quiver package to simulate time
      new FakeAsync().run((time) {
        final service = new MockService();
      sl.registerSingleton<WeatherService>(service);
        final manager = new AppManager();

        when(service.getWeatherEntriesForCity(typed(any as ArgMatcher)))
            .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

        manager.textChangedCommand('A');
        time.elapse(new Duration(milliseconds: 1000));

        verify(service.getWeatherEntriesForCity('A'));
      });
    });

    test('should not search if the user has not paused for 500ms', () async {
      // Use FakeAsync from the Quiver package to simulate time
      new FakeAsync().run((time) {
      final service = new MockService();
      sl.registerSingleton<WeatherService>(service);
      final manager = new AppManager();

        when(service.getWeatherEntriesForCity(typed(any as ArgMatcher)))
            .thenAnswer((_) => new Future.sync(() => <WeatherEntry>[]));

        manager.textChangedCommand('A');
        time.elapse(new Duration(milliseconds: 100));

        verifyNever(service.getWeatherEntriesForCity('A'));
      });
    });
  });
}
