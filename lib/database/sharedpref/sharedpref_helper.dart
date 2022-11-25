import 'package:eco_bee_weather_app_flutter/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String theme_mode = 'theme_mode';
const String theme_mode_light = 'light';
const String theme_mode_dark = 'dark';

const String selectedUnit = 'unit';

Future<bool> setThemeModeDark(bool darkMode) async {
  final pref = await SharedPreferences.getInstance();
  return await pref.setBool(theme_mode, darkMode);
}

Future<bool> isThemeModeDark() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool(theme_mode) ?? false;
}

Future<bool> setSelectedUnit(String unit) async {
  final pref = await SharedPreferences.getInstance();
  return await pref.setString(selectedUnit, unit);
}

Future<bool> isUnitMetric() async {
  final pref = await SharedPreferences.getInstance();
  print('GET : ${pref.getString(selectedUnit)}');
  return (pref.getString(selectedUnit) ?? unitMetric) == unitMetric;
}
