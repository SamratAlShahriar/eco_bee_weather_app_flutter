import 'package:geolocator/geolocator.dart';

const String owmApiKey = '272a73a969ee3c2362c695bbc0448e30';
const String baseUrl = 'https://api.openweathermap.org/data/2.5';
const String typeWeather = 'weather';
const String typeForecast = 'forecast';

const String unitMetric = 'metric';
const String unitImperial = 'imperial';
const String symbolFahrenheit = 'F';
const String symbolCelsius = 'C';
const String symbolDegree = '\u00B0';

const String dfyyyyMMdd = 'yyyy-MM-dd';
const String dfEEEyyyyMMdd = 'EEE MMM dd, yyyy';
const String dfMMdd = 'MMM dd';
const String df24Hour = 'HH:mm';
const String df12Hour = 'hh:mm a';
const String df12HourWithWeekDay = 'EEE hh:mm a';
const String dfWeekDay = 'EEE';
const String df24HourWithDate = 'yyyy-MM-dd HH:mm';
const String df12HourWithDate = 'yyyy-MM-dd hh:mm a';

String generateUrl(
        {required String type,
        required double latitude,
        required double longitude,
        required String unit}) =>
    '$baseUrl/$type?lat=$latitude&lon=$longitude&units=$unit&appid=$owmApiKey';

String generateWeatherIconUrl(String code) {
  return 'http://openweathermap.org/img/wn/$code@2x.png';
}
