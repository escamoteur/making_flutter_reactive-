import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rx_command/rx_command.dart';

import '../service/weather_entry.dart';
import '../service/weather_service.dart';


  class HomePageAppModel {


    RxCommand<String,List<WeatherEntry>>  updateWeatherCommand;
    RxCommand<bool,bool>  switchChangedCommand;
    RxCommand<String,String>  textChangedCommand;

    HomePageAppModel()
    {
        // Command expects a bool value when executed and issues the value on it's result Observable (stream)
        switchChangedCommand = RxCommand.createSync3<bool,bool>((b)=>b);

        // We pass the result of switchChangedCommand as canExecute Observable to the upDateWeatherCommand
        updateWeatherCommand = RxCommand.createAsync3<String,List<WeatherEntry>>(update,switchChangedCommand.results);

        // Will be called on every change of the searchfield
        textChangedCommand = RxCommand.createSync3((s) => s);

        // handler for results
        textChangedCommand.results
          .debounce( new Duration(milliseconds: 500))  // make sure we start processing only if the user make a short pause typing 
            .listen( (filterText)
            {
              updateWeatherCommand.execute( filterText); // I could omit he execute because RxCommand is a callable class but here it 
                                                         //  makes the intention clearer
            });  

        // Update data on startup
        updateWeatherCommand.execute();
    }



    Future<List<WeatherEntry>> update(String filtertext)
    {
          return WeatherService.getWeatherEntriesForCity(filtertext).first;
    }
 
}
                          
 


