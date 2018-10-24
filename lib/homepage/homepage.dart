import 'package:flutter/material.dart';
import 'package:making_flutter_more_reactive/homepage/weather_list_view.dart';
import 'package:making_flutter_more_reactive/keys.dart';
import 'package:making_flutter_more_reactive/managers/app_manager.dart';
import 'package:making_flutter_more_reactive/service_locator.dart';

import 'package:rx_widgets/rx_widgets.dart';

import 'package:making_flutter_more_reactive/services/weather_entry.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WeatherDemo")),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              key: AppKeys.textField,
              autocorrect: false,
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Filter cities",
              ),
              style: TextStyle(
                fontSize: 20.0,
              ),
              onChanged: sl.get<AppManager>().textChangedCommand,
            ),
          ),
          Expanded(
            child: RxLoader<List<WeatherEntry>>(
              spinnerKey: AppKeys.loadingSpinner,
              radius: 25.0,
              commandResults: sl.get<AppManager>().updateWeatherCommand.results,
              dataBuilder: (context, data) =>
                  WeatherListView(data, key: AppKeys.weatherList),
              placeHolderBuilder: (context) => Center(
                  key: AppKeys.loaderPlaceHolder, child: Text("No Data")),
              errorBuilder: (context, ex) => Center(
                  key: AppKeys.loaderError,
                  child: Text("Error: ${ex.toString()}")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child:
                      // This might be solved with a Streambuilder too but it should show `WidgetSelector`
                      WidgetSelector(
                    buildEvents: sl
                        .get<AppManager>()
                        .updateWeatherCommand
                        .canExecute, //We access our ViewModel through the inherited Widget
                    onTrue: RaisedButton(
                        key: AppKeys.updateButtonEnabled,
                        child: Text("Update"),
                        onPressed: () {
                          _controller.clear();
                          sl.get<AppManager>().updateWeatherCommand();
                        }),
                    onFalse: RaisedButton(
                      key: AppKeys.updateButtonDisabled,
                      child: Text("Please Wait"),
                      onPressed: null,
                    ),
                  ),
                ),
                StateFullSwitch(
                  state: true,
                  onChanged: sl.get<AppManager>().switchChangedCommand,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// As the normal switch does not even remember and display its current state
/// we us this one
class StateFullSwitch extends StatefulWidget {
  final bool state;
  final ValueChanged<bool> onChanged;

  StateFullSwitch({this.state, this.onChanged});

  @override
  StateFullSwitchState createState() {
    return StateFullSwitchState(state, onChanged);
  }
}

class StateFullSwitchState extends State<StateFullSwitch> {
  bool state;
  ValueChanged<bool> handler;

  StateFullSwitchState(this.state, this.handler);

  @override
  Widget build(BuildContext context) {
    return Switch(
      key: AppKeys.updateSwitch,
      value: state,
      onChanged: (b) {
        setState(() => state = b);
        handler(b);
      },
    );
  }
}
