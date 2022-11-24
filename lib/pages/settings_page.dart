import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/weather_provider.dart';
import '../utils/weather_preferences.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool tempUnitStatus = false;
  bool is24Hour = false;

  @override
  void initState() {
    getBool(prefUnit).then((value) {
      setState(() {
        tempUnitStatus = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          SwitchListTile(
            value: tempUnitStatus,
            onChanged: (value) async {
              setState(() {
                tempUnitStatus = value;
              });
              await setBool(prefUnit, value);
              context.read<WeatherProvider>().setTempUnit(value);
            },
            title: const Text('Show temperature in Fahrenheit'),
            subtitle: const Text('Default is Celsius'),
          ),
          SwitchListTile(
            value: is24Hour,
            onChanged: (value) async {
              setState(() {
                is24Hour = value;
              });
              await setBool(prefTimeFormat, value);
            },
            title: const Text('Show time in 24 hour format'),
            subtitle: const Text('Default is 12 hour'),
          )
        ],
      ),
    );
  }
}
