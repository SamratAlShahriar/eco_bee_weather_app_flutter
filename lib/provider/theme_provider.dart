import 'package:flutter/material.dart';

import '../database/sharedpref/sharedpref_helper.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void getPrefTheme() async{
    _themeMode = await isThemeModeDark() ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleMode() {
    if(_themeMode == ThemeMode.light){
      setThemeModeDark(true);
    } else {
      setThemeModeDark(false);
    }
    getPrefTheme();
  }
}