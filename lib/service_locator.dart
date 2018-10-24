
import 'package:get_it/get_it.dart';
import 'package:making_flutter_more_reactive/managers/app_manager.dart';
import 'package:making_flutter_more_reactive/services/weather_service.dart';
import 'package:http/http.dart' as http;

GetIt sl = new GetIt();

void setUpServiceLocator( )
 {
  sl.registerSingleton<WeatherService>(new WeatherService(new http.Client()));

// Managers

  sl.registerSingleton<AppManager>(new AppManager());

}
