import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_demo/homepage/homepage_model.dart';
import 'package:flutter_weather_demo/homepage/weather_list_view.dart';
import 'package:flutter_weather_demo/keys.dart';
import 'package:flutter_weather_demo/model_provider.dart';
import 'package:flutter_weather_demo/service/weather_entry.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

class MockModel extends Mock implements HomePageModel {}

class MockCommand<Param, Result> extends Mock
    implements RxCommand<Param, Result> {}

main() {
  group('WeatherListView', () {
    testWidgets('Shows a blank box waiting for data', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String, List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new WeatherListView()),
      );

      when(model.updateWeatherCommand).thenReturn(command);
      when(command.results)
          .thenAnswer((_) => new Observable.just(<WeatherEntry>[]));

      await tester.pumpWidget(widget); // Build initial state

      expect(find.byKey(AppKeys.empty), findsOneWidget);
    });

    testWidgets('Shows no results found if empty', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String, List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new WeatherListView()),
      );

      when(model.updateWeatherCommand).thenReturn(command);
      when(command.results)
          .thenAnswer((_) => new Observable.just(<WeatherEntry>[]));

      await tester.pumpWidget(widget); // Build initial state
      await tester.pump(); // Build with empty list

      expect(find.byKey(AppKeys.noItems), findsOneWidget);
    });

    testWidgets('Shows list of results if items is populated', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String, List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(
          home: new Material(child: new WeatherListView()),
        ),
      );

      when(model.updateWeatherCommand).thenReturn(command);
      when(command.results).thenAnswer((_) => new Observable.just(
          [new WeatherEntry('', 20.0, 4.5, 'Lookin good.', 800)]));

      await tester.pumpWidget(widget); // Build initial state
      await tester.pump(); // Build with empty list

      expect(find.byKey(AppKeys.cityList), findsOneWidget);
    });
  });
}
