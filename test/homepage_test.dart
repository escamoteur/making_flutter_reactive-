import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_demo/homepage/homepage.dart';
import 'package:flutter_weather_demo/homepage/homepage_model.dart';
import 'package:flutter_weather_demo/keys.dart';
import 'package:flutter_weather_demo/model_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';

import '../lib/service/weather_entry.dart';

class MockModel extends Mock implements HomePageModel {}

class MockCommand<TParam,TResult> extends Mock implements RxCommand<TParam,TResult> {}

main() {
  group('HomePage', () {
    testWidgets('Shows a loading spinner when executing', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(command).thenReturn(new Observable<CommandResult<WeatherEntry>>.just(new CommandResult<WeatherEntry>(new WeatherEntry("Test",0.0,0.0,"TestCondition",0), null, true)));
      when(model.updateWeatherCommand).thenReturn(command);

      await tester.pumpWidget(widget);

      expect(find.byKey(AppKeys.loadingSpinner), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
    });

 /*    testWidgets('Shows the weather list when done executing', (tester) async {
      final model = new MockModel();
      final command = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(command);
      when(command).thenAnswer((_) => new Observable<CommandResult<WeatherEntry>>.just(new CommandResult<WeatherEntry>(new WeatherEntry("Test",0.0,0.0,"TestCondition",0), null, false)));

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsOneWidget);
    });
 
    testWidgets('Shows the place holder if no data', (tester) async {
      final model = new MockModel();
      final command = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(command);
      when(command.isExecuting).thenAnswer((_) => new Observable.just(false));

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsOneWidget);
    });

    testWidgets('Tapping update button updates the weather', (tester) async {
      final model = new MockModel();
      final command = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(command.canExecute).thenAnswer((_) => new Observable.just(true));
      when(model.updateWeatherCommand).thenReturn(command);

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value
      await tester.tap(find.byKey(AppKeys.updateButton));

      verify(model.updateWeatherCommand(''));
    });

    testWidgets('update button updates using the text filter', (tester) async {
      final model = new MockModel();
      final command = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(command.canExecute).thenAnswer((_) => new Observable.just(true));
      when(model.updateWeatherCommand).thenReturn(command);

      await tester.pumpWidget(widget); // Build initial State
      await tester.enterText(find.byKey(AppKeys.textField), 'Berlin');
      await tester.pump(); // Build after text entered
      await tester.tap(find.byKey(AppKeys.updateButton));

      verify(model.updateWeatherCommand('Berlin'));
    });

    testWidgets('cannot tap update button when disabled', (tester) async {
      final model = new MockModel();
      final command = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(command.canExecute).thenAnswer((_) => new Observable.just(false));
      when(model.updateWeatherCommand).thenReturn(command);

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value
      await tester.tap(find.byKey(AppKeys.updateButton));

      verifyNever(model.updateWeatherCommand(''));
    });

    testWidgets('tapping switch toggles model', (tester) async {
      final model = new MockModel();
      final updateCommand = new MockCommand();
      final switchCommand = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(updateCommand);
      when(updateCommand.isExecuting)
          .thenAnswer((_) => new Observable.just(true));
      when(model.switchChangedCommand).thenReturn(switchCommand);

      await tester.pumpWidget(widget); // Build initial State
      await tester.pumpWidget(widget); // Build initial State
      await tester.tap(find.byKey(AppKeys.updateSwitch));

      // Starts out true, tapping should go false
      verify(switchCommand.call(false));
    });*/
  });
}
