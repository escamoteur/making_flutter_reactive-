import 'package:rxdart/rxdart.dart';

import '../service/weather_entry.dart';
import '../service/weather_service.dart';

  class HomePageAppModel {
  
    // Subjects are like StreamSinks. You can queue new events that are then published on the .obersvable property of th subject. 
    final _newWeatherSubject = new BehaviorSubject<List<WeatherEntry>>() ;
    
    // Only the observable of the Subject gets published
    Observable<List<WeatherEntry>> get newWeatherEvents  => _newWeatherSubject.observable;
    

    final _inputSubject = new BehaviorSubject<String>() ;

    // Callback function that will be registered to the TextFields OnChanged Event
     onFilerEntryChanged(String s) => _inputSubject.add(s); 



    HomePageAppModel()
    {
        update(); // get weather data at startup. Important, this won't update the UI, it just retrieves the data 
                  // and queues it in the _newWeatherSubject. Only if a widget is listening to the Observable side it will be updated.

        // initialize input listener for the Searchfield
        _inputSubject.observable
          .debounce( new Duration(milliseconds: 500))  // make sure we start processing if the user make a short pause 
            .listen( (filterText)
            {
              update( filtertext: filterText);
            });  
    }



    update({String filtertext = ""})
    {
         _newWeatherSubject.addStream( WeatherService.getWeatherEntriesForCity(filtertext)
                                                          .handleError((error)=> print)       // if there is an error while accessing the REST API we just make a debug output
                                      );          
    }
 
}
                          
 


