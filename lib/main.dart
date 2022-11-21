import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_1/pages/home_page.dart';
import 'package:weather_app_1/providers/weather_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>WeatherProvider()),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) =>HomePage(),

      },
    );
  }
}
