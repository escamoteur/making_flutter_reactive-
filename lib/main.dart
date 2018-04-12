import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'homepage/homepage.dart';
import 'homepage/homepage_appmodel.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 
  @override
  Widget build(BuildContext context) {
    return new TheViewModel( 
                  theModel:  new HomePageAppModel(),
                  child: 
                  new MaterialApp(
                    title: 'Flutter Demo',
                    home: new HomePage()


                  ),
    );
  }
}



// InheritedWidgets allow you to propagate values down the widgettree. 
// it can then be accessed by just writing  TheViewModel.of(context)
class TheViewModel extends InheritedWidget
{
  final HomePageAppModel theModel;

  const TheViewModel({Key key, 
                      @required 
                      this.theModel, 
                      @required 
                      Widget child}) :  assert(theModel != null),assert(child != null),
                      super(key: key, child: child);

  static HomePageAppModel of(BuildContext context) => (context.inheritFromWidgetOfExactType(TheViewModel)as TheViewModel).theModel;                  


  @override
  bool updateShouldNotify(TheViewModel oldWidget) => theModel != oldWidget.theModel;
  
}

