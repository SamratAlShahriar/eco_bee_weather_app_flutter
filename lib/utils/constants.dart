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

String generateUrl(
        {required String type,
        required Position position,
        required String unit}) =>
    '$baseUrl/$type?lat=${position.latitude}&lon=${position.longitude}&units=$unit&appid=$owmApiKey';

