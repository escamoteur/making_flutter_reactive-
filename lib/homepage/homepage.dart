import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'listview.dart';
import '../main.dart';

 
 class HomePage extends StatelessWidget
 {
  @override
  Widget build(BuildContext context) {
      return 
         new Scaffold(
            appBar: new AppBar(title: new Text("WeatherDemo")),
            body: 
              new Column(children: <Widget>
              [
               new Padding(padding: const EdgeInsets.all(5.0),child: 
                      new TextField(
                              autocorrect: false,
                              decoration: new InputDecoration(
                                                  hintText: "Filter cities",
                                                  hintStyle: new TextStyle(color: new Color.fromARGB(150, 0, 0, 0)),
                                                  ),
                              style: new TextStyle(
                                            fontSize: 20.0,
                                            color: new Color.fromARGB(255, 0, 0, 0)),
                              onChanged: TheViewModel.of(context).textChangedCommand,),
                ),

                new Expanded( child: 
                    new RxSpinner(busyEvents: TheViewModel.of(context).updateWeatherCommand.isExecuting,
                                  platform: TargetPlatform.android,
                                  radius: 20.0,
                                  normal: new WeatherListView(),) 
                ), 
                                
                new Padding(padding: const EdgeInsets.all(8.0),
                    child: 
                        // We use a stream builder to toggle the enabled state of the button
                      new Row(
                        children: <Widget>[
                          new Expanded(
                                child: new WidgetSelector(buildEvents: TheViewModel.of(context).updateWeatherCommand.canExecute,   //We access our ViewModel through the inherited Widget
                                onTrue:  new RaisedButton(                               
                                              child: new Text("Update"), 
                                              color: new Color.fromARGB(255, 33, 150, 243),
                                              textColor: new Color.fromARGB(255, 255, 255, 255),
                                              onPressed: TheViewModel.of(context).updateWeatherCommand,
                                              ),
                                onFalse:  new RaisedButton(                               
                                                child: new Text("Update"), 
                                                color: new Color.fromARGB(255, 33, 150, 243),
                                                textColor: new Color.fromARGB(255, 255, 255, 255),
                                                onPressed: null,
                                              ),
                                      
                                  ),
                          ),
                                new StateFullSwitch(state: true,
                                    onChanged: TheViewModel.of(context).switchChangedCommand)
                        ],
                      )                                              
                
                ),
                
              ],
            ),
          );
  }
   
 }
 
 /// As the normal switch does not even remeber and display its current state 
 ///  we us this one 
class StateFullSwitch extends StatefulWidget
{
    final bool state;
    final ValueChanged<bool> onChanged;

    StateFullSwitch({this.state, this.onChanged});

    @override
    StateFullSwitchState createState() {
    return new StateFullSwitchState(state, onChanged);
    }

}

class StateFullSwitchState extends State<StateFullSwitch> 
{
    
    bool state;
    ValueChanged<bool> handler;
    
    StateFullSwitchState(this.state, this.handler);    

    @override 
    Widget build(BuildContext context) {
        return new Switch(value: state, onChanged: (b) { setState(()=> state = b); handler(b);});
        }
}