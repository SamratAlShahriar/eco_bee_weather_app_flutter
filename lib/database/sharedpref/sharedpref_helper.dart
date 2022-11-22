import 'package:shared_preferences/shared_preferences.dart';

const String theme_mode = 'theme_mode';
const String theme_mode_light = 'light';
const String theme_mode_dark = 'dark';

Future<bool> setThemeModeDark(bool darkMode) async {
  final pref = await SharedPreferences.getInstance();
  return await pref.setBool(theme_mode, darkMode);
}

Future<bool> isThemeModeDark() async{
  final pref = await SharedPreferences.getInstance();
  return await pref.getBool(theme_mode) ?? false;
}