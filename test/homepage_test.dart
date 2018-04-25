import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_command/rx_command.dart';
import 'package:making_flutter_more_reactive/homepage/homepage.dart';
import 'package:making_flutter_more_reactive/homepage/homepage_model.dart';
import 'package:making_flutter_more_reactive/keys.dart';
import 'package:making_flutter_more_reactive/model_provider.dart';
import 'package:making_flutter_more_reactive/service/weather_entry.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';



class MockModel extends Mock implements HomePageModel {}

//class MockCommand<TParam,TResult> extends Mock implements RxCommand<TParam,TResult> {}


class MockStream<T>  extends Mock implements Stream<T>{}

main() {
  group('HomePage', () {
    testWidgets('Shows a loading spinner and disables the button while executing and shows the ListView on data arrival', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_)=>command);

//      model.updateWeatherCommand.canExecute.listen((b) => print("Can exceute: $b"));
//      model.updateWeatherCommand.isExecuting.listen((b) => print("Is Exceuting: $b"));

      await tester.pumpWidget(widget);// Build initial State
      await tester.pump(); 

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);


      command.startExecution();
      await tester.pump(); 
      await tester.pump();  //because there are two streams involded it seems we have to pump twice so that both streambuilders can work

      expect(find.byKey(AppKeys.loadingSpinner), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);

      command.endExecutionWithData([new WeatherEntry("London", 10.0, 30.0, "sunny", 12)]);
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsOneWidget);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);
    });


    testWidgets('shows place holder due to no data', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_)=>command);

 //     model.updateWeatherCommand.canExecute.listen((b) => print("Can exceute: $b"));
 //     model.updateWeatherCommand.isExecuting.listen((b) => print("Is Exceuting: $b"));

      await tester.pumpWidget(widget);// Build initial State
      await tester.pump(); 

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);


      command.startExecution();
      await tester.pump(); 
      await tester.pump();  //because there are two streams involded it seems we have to pump twice so that both streambuilders can work

      expect(find.byKey(AppKeys.loadingSpinner), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);

      command.endExecutionWithData(null);
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);
    });

    testWidgets('Shows error view due to received error', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_)=>command);

 //     model.updateWeatherCommand.canExecute.listen((b) => print("Can exceute: $b"));
 //     model.updateWeatherCommand.isExecuting.listen((b) => print("Is Exceuting: $b"));

      await tester.pumpWidget(widget);// Build initial State
      await tester.pump(); 

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);


      command.startExecution();
      await tester.pump(); 
      await tester.pump();  //because there are two streams involded it seems we have to pump twice so that both streambuilders can work

      expect(find.byKey(AppKeys.loadingSpinner), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);

      command.endExecutionWithError("Intentional");
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsOneWidget);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);
    });


 

    testWidgets('Tapping update button updates the weather', (tester) async {
      final model = new MockModel();
     final command = new MockCommand<String,List<WeatherEntry>>();
       final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_)=>command);
      when(model.updateWeatherCommand()).thenAnswer((_)=>command());

      command.queueResultsForNextExecuteCall([CommandResult<List<WeatherEntry>>(
                  [WeatherEntry("London", 10.0, 30.0, "sunny", 12)],null, false)]);

      expect(command, emitsInOrder([ crm([WeatherEntry("London", 10.0, 30.0, "sunny", 12)], false, false) ]));

      command.listen((data)=> print("Received: " + data.data.toString()));

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value
      await tester.tap(find.byKey(AppKeys.updateButtonEnabled));


    });

    testWidgets('calls updateWeatherCommand after  text was entered in the textfield', (tester) async {
      final model = new MockModel();
      final commandUpdate = new MockCommand<String,List<WeatherEntry>>(); 
      final commandTextChange = new MockCommand<String,String>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_)=>commandUpdate); //Allways needed because RxLoader binds to it
      when(model.textChangedCommand).thenAnswer((_)=>commandTextChange);
 
      await tester.pumpWidget(widget); // Build initial State
      await tester.enterText(find.byKey(AppKeys.textField), 'London');
      await tester.pump(); // Build after text entered
      await tester.tap(find.byKey(AppKeys.updateButtonEnabled));

      expect(commandTextChange.lastPassedValueToExecute,"London");
    });



    testWidgets('cannot tap update  when commandUpdate is  disabled', (tester) async {
      final model = new MockModel();
      final commandUpdate = new MockCommand<String,List<WeatherEntry>>(canExecute:  new Observable.just(false)); 

      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_)=>commandUpdate); //Allways needed because RxLoader binds to it
      when(model.updateWeatherCommand()).thenAnswer((_)=>commandUpdate());


      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value
      await tester.pump(); // Build after Stream delivers value

     expect(find.byKey(AppKeys.updateButtonDisabled), findsOneWidget); // should display disabled button
     expect(find.byKey(AppKeys.updateButtonEnabled), findsNothing); // should not display enabled button


      await tester.tap(find.byKey(AppKeys.updateButtonDisabled));

      expect(commandUpdate.executionCount, 0);
    });



    testWidgets('tapping switch toggles model', (tester) async {
      final model = new MockModel();
      final updateCommand = new MockCommand<String,List<WeatherEntry>>(canExecute:  new Observable.just(false)); 
      final switchCommand = new MockCommand<bool,bool>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_) => updateCommand);
      when(model.switchChangedCommand).thenAnswer((_) => switchCommand);

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); 

      await tester.tap(find.byKey(AppKeys.updateSwitch));

      // Starts out true, tapping should go false
      expect(switchCommand.lastPassedValueToExecute, false);
      await tester.pump(); 

      // tap again
      await tester.tap(find.byKey(AppKeys.updateSwitch));

      expect(switchCommand.lastPassedValueToExecute, true);
    });


    testWidgets('Tapping update button clears the filter field', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenAnswer((_) =>command);


      await tester.pumpWidget(widget); // Build initial State
      await tester.enterText(find.byKey(AppKeys.textField), 'London');

      await tester.pump(); // Build after Stream delivers value
      await tester.tap(find.byKey(AppKeys.updateButtonEnabled));
    
      expect(tester.widget<TextField>(find.byKey(AppKeys.textField)).controller.text.length, 0);

    });



  });
}







  StreamMatcher crm(List<WeatherEntry> data, bool hasError, bool isExceuting)
  {
      return new StreamMatcher((x) async {
                                              CommandResult<List<WeatherEntry>> event =  await x.next;
                                              if (event.data != null)
                                              {
                                                 if (!ListEquality().equals(event.data, data))
                                                 {
                                                   return "Data not equal";
                                                 }
                                              }    

                                              if (!hasError && event.error != null)
                                                return "Had error while not expected";

                                              if (hasError && !(event.error is Exception))
                                                return "Wong error type";

                                              if (event.isExecuting != isExceuting)
                                                return "Wong isExecuting $isExceuting";

                                              return null;
                                          }, "Wrong value emmited:");
  }
