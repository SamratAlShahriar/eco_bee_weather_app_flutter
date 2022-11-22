import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../database/http/http_helper.dart';
import '../model/forecast_response_model.dart';
import '../model/weather_response_model.dart';
import '../utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherResponseModel? weatherResponse;
  ForecastResponseModel? forecastResponse;

  bool hasDataLoaded = false;

  void getResponse({required Position position, String unit = unitMetric}) async{
    weatherResponse = await _getWeatherResponse(position: position, unit: unit);
    forecastResponse = await _getForecastResponse(position: position, unit: unit);
    if(weatherResponse != null && forecastResponse != null){
      hasDataLoaded = true;
    }
    print('ok');
    notifyListeners();
  }

  Future<WeatherResponseModel> _getWeatherResponse(
      {required Position position, required String unit}) async {
    return await HttpHelper.getResponse(
        type: typeWeather, position: position, unit: unit);
  }

  Future<ForecastResponseModel> _getForecastResponse(
      {required Position position, required String unit}) async {
    return await HttpHelper.getResponse(
        type: typeForecast, position: position, unit: unit);
  }
}
