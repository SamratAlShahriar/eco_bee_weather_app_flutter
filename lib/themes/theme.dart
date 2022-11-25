import 'package:flutter/material.dart';

ThemeData ecoBeeThemeLight = _buildThemeLight();
ThemeData ecoBeeThemeDark = _buildThemeDark();

ThemeData _buildThemeDark() {
  ThemeData baseDark = ThemeData.dark();
  return baseDark.copyWith(
    textTheme: _buildTextThemeDark(baseDark),
  );
}

ThemeData _buildThemeLight() {
  ThemeData baseLight = ThemeData.light();
  return baseLight.copyWith(
    scaffoldBackgroundColor: Colors.black.withOpacity(0.25),
    textTheme: _buildTextThemeLight(baseLight),
  );
}

TextTheme _buildTextThemeLight(ThemeData baseLight) {
  return baseLight.textTheme.copyWith(

  ).apply(
        bodyColor: Colors.white,
      );
}

TextTheme _buildTextThemeDark(ThemeData baseDark) {
  return baseDark.textTheme.copyWith();
}
