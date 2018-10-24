import 'package:flutter/material.dart';
import 'package:making_flutter_more_reactive/homepage/homepage.dart';
import 'package:making_flutter_more_reactive/service_locator.dart';

void main() {
  setUpServiceLocator();
  runApp( MyApp(
  ));
}

class MyApp extends StatelessWidget {

  const MyApp({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
        title: 'Flutter Demo',
        theme:  ThemeData.dark().copyWith(
          disabledColor: Colors.white12,
          primaryColor:  Color(0xFF1C262A),
          buttonColor:  Color(0xFF1C262A),
          accentColor:  Color(0xFFA7D9D5),
          scaffoldBackgroundColor:  Color.fromRGBO(38, 50, 56, 1.0),
        ),
        home:  HomePage(),
    
    );
  }
}
