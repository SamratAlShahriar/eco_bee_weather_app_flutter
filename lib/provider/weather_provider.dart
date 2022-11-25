import 'package:flutter/material.dart';

import '../database/http/http_helper.dart';
import '../database/sharedpref/sharedpref_helper.dart';
import '../model/forecast_response_model.dart';
import '../model/weather_response_model.dart';
import '../utils/constants.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherResponseModel? weatherResponse;
  ForecastResponseModel? forecastResponse;
  String _backgroundImagePath = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _tempUnit = unitMetric;
  String unitSymbol = symbolCelsius;

  WeatherProvider() {
    getTempUnit();
  }

  void setBgImageOPath() {
    if (hasDataLoaded) {}
  }

  bool get isMetric => _tempUnit == unitMetric;

  Future<void> getTempUnit() async {
    _tempUnit = await isUnitMetric() ? unitMetric : unitImperial;
    unitSymbol = _tempUnit == unitMetric ? symbolCelsius : symbolFahrenheit;
  }

  bool get hasDataLoaded => weatherResponse != null && forecastResponse != null;

  Future<void> setUnit(String unit) async{
    await setSelectedUnit(unit);
    await getTempUnit();
    getResponses();
  }

  void setNewLatLon({required double lat, required double lon}) {
    _latitude = lat;
    _longitude = lon;
  }

  void getResponses() async {
    forecastResponse = await _getForecastResponse();
    weatherResponse = await _getWeatherResponse();
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
        unit: _tempUnit,
        latitude: _latitude,
        longitude: _longitude,
      );
}
