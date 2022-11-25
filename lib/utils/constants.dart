import 'package:geolocator/geolocator.dart';

// ref url https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=272a73a969ee3c2362c695bbc0448e30


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

String getWeatherIconByCode(String code) {
  switch (code) {
    case '01d': //clear sky day
      return 'assets/icons/clear_sky_d.svg';
    case '01n': //clear sky night
      return 'assets/icons/clear_sky_n.svg';
    case '02d': //few clouds day
      return 'assets/icons/few_clouds_d.svg';
    case '02n': //few clouds night
      return 'assets/icons/few_clouds_n.svg';
    case '03d': //scattered clouds day
      return 'assets/icons/scattered_clouds_d.svg';
    case '03n': //scattered clouds night
      return 'assets/icons/scattered_clouds_n.svg';
    case '04d': //broken clouds day
      return 'assets/icons/broken_clouds_dn.svg';
    case '04n': //broken clouds night
      return 'assets/icons/broken_clouds_dn.svg';
    case '09d': //shower rain day
      return 'assets/icons/shower_rain_d.svg';
    case '09n': //shower rain night
      return 'assets/icons/shower_rain_n.svg';
    case '10d': //rain day
      return 'assets/icons/rain_d.svg';
    case '10n': //rain night
      return 'assets/icons/rain_n.svg';
    case '11d': //thunderstorm day
      return 'assets/icons/thunder_d.svg';
    case '11n': //thunderstorm night
      return 'assets/icons/thunder_n.svg';
    case '13d': //snow day
      return 'assets/icons/snow_d.svg';
    case '13n': //snow night
      return 'assets/icons/snow_n.svg';
    case '50d': //mist day (haze)
      return 'assets/icons/haze_d.svg';
    case '50n': // mist night (haze)
      return 'assets/icons/haze_n.svg';
    default:
      return '';
  }
}
