import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_1/models/current_weather_api_model.dart';
import 'package:http/http.dart' as Http;
import 'package:weather_app_1/models/forecast_weather_api_model.dart';
import '../utils/constants.dart';

class WeatherProvider extends ChangeNotifier{

  CurrentWeatherResponse currentWeatherResponse=CurrentWeatherResponse();
  ForecastWeatherResponse forecastWeatherResponse = ForecastWeatherResponse();
  double latitude=0.0;
  double longitude=0.0;
  String tempUnitSymbole='';
  String tempUnit='';



  Future<void>getCurrentWeatherDate(Position position)async{
    final urlString ="https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=$tempUnit&appid=$weatherApiKey";
    final response=await Http.get(Uri.parse(urlString));
    final map = json.decode(response.body);
    if(response.statusCode==200){
      currentWeatherResponse=CurrentWeatherResponse.fromJson(map);
      print(currentWeatherResponse.main!.temp.toString());
    }
    notifyListeners();
    
  }

}