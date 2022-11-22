import 'package:eco_bee_weather_app_flutter/pages/home_page.dart';
import 'package:eco_bee_weather_app_flutter/pages/launcher_page.dart';
import 'package:eco_bee_weather_app_flutter/pages/settings_page.dart';
import 'package:eco_bee_weather_app_flutter/provider/theme_provider.dart';
import 'package:eco_bee_weather_app_flutter/provider/weather_provider.dart';
import 'package:eco_bee_weather_app_flutter/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'ECO-Bee',
      theme: ecoBeeThemeLight,
      darkTheme: ecoBeeThemeDark,
      themeMode: themeProvider.themeMode,
      initialRoute: Homepage.routeName,
      routes: {
        LauncherPage.routeName: (_) => const LauncherPage(),
        Homepage.routeName: (_) => Homepage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
      },
    );
  }
}
