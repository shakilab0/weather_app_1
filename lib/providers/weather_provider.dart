import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as Http;


import '../models/current_weather_response.dart';
import '../models/forecast_weather_response.dart';
import '../utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentWeatherResponse? currentWeatherResponse;
  ForecastWeatherResponse? forecastWeatherResponse;

  double latitude = 0.0;
  double longitude = 0.0;
  String tempUnit = metric;
  String tempUnitSymbol = celsius;

  void setNewPosition(double lat, double lng) {
    latitude = lat;
    longitude = lng;
  }

  void setTempUnit(bool status) {
    tempUnit = status ? imperial : metric;
    tempUnitSymbol = status ? fahrenheit : celsius;
    getData();
  }

  bool get hasDataLoaded =>
      currentWeatherResponse != null && forecastWeatherResponse != null;

  void getData() {
    _getCurrentWeatherDate();
    _getForecastWeatherDate();
  }

  Future<void> _getCurrentWeatherDate() async {
    final urlString =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=$tempUnit&appid=$weatherApiKey';
    try {
      final response = await Http.get(Uri.parse(urlString));
      final map = json.decode(response.body);
      if (response.statusCode == 200) {
        currentWeatherResponse = CurrentWeatherResponse.fromJson(map);
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _getForecastWeatherDate() async {
    final urlString =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=$tempUnit&appid=$weatherApiKey';
    try {
      final response = await Http.get(Uri.parse(urlString));
      final map = json.decode(response.body);
      if (response.statusCode == 200) {
        forecastWeatherResponse = ForecastWeatherResponse.fromJson(map);
        notifyListeners();
      } else {
        print(map['message']);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> convertAddressToLocation(String address) async {
    try {
      final locationList = await locationFromAddress(address);
      if (locationList.isNotEmpty) {
        final location = locationList.first;
        latitude = location.latitude;
        longitude = location.longitude;
        getData();
      } else {
        print('No location found from your provided address');
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
