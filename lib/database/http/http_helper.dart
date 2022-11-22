import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http_client;

import '../../model/forecast_response_model.dart';
import '../../model/weather_response_model.dart';
import '../../utils/constants.dart';

class HttpHelper {
  static Future<dynamic> getResponse(
      {required String type,
      required Position position,
      required String unit}) async {
    final response =
        await http_client.get(Uri.parse(generateUrl(type:type, position: position, unit: unit)));

    final jsonMap = json.decode(response.body);
    if(response.statusCode == 200){
      if(type == typeWeather){
        return WeatherResponseModel.fromJson(jsonMap);
      } else if(type == typeForecast){
        return ForecastResponseModel.fromJson(jsonMap);
      }
    }
  }
}
