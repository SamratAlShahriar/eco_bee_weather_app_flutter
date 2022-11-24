import 'package:flutter/material.dart';

import '../database/http/http_helper.dart';
import '../model/forecast_response_model.dart';
import '../model/weather_response_model.dart';
import '../utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherResponseModel? weatherResponse;
  ForecastResponseModel? forecastResponse;
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _tempUnit = unitMetric;
  String unitSymbol = symbolCelsius;

  bool get hasDataLoaded => weatherResponse != null && forecastResponse != null;

  void setUnit(String unit) {
    _tempUnit = unit;
    notifyListeners();
  }

  void setNewLatLon({required double lat, required double lon}) {
    _latitude = lat;
    _longitude = lon;
  }

  void getResponses() async {
    weatherResponse = await _getWeatherResponse();
    forecastResponse = await _getForecastResponse();
    notifyListeners();
  }

  Future<WeatherResponseModel> _getWeatherResponse() async =>
      await HttpHelper.getResponse(
        type: typeWeather,
        unit: _tempUnit,
        latitude: _latitude,
        longitude: _longitude,
      );

  Future<ForecastResponseModel> _getForecastResponse() async =>
      await HttpHelper.getResponse(
        type: typeForecast,
        latitude: _latitude,
        longitude: _longitude,
        unit: _tempUnit,
      );
}
