import 'package:eco_bee_weather_app_flutter/provider/theme_provider.dart';
import 'package:eco_bee_weather_app_flutter/provider/weather_provider.dart';
import 'package:eco_bee_weather_app_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Unit',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ToggleSwitch(
                  minWidth: 40.0,
                  initialLabelIndex: weatherProvider.isMetric ? 0 : 1,
                  cornerRadius: 5.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.black.withOpacity(0.5),
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: const ['C', 'F'],
                  icons: null,
                  activeBgColors: const [
                    [Colors.red],
                    [Colors.red],
                  ],
                  onToggle: (index) {
                    if (index == 0) {
                      weatherProvider.setUnit(unitMetric);
                    } else {
                      weatherProvider.setUnit(unitImperial);
                    }
                    print(index);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Theme',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex:
                      themeProvider.themeMode == ThemeMode.light ? 0 : 1,
                  cornerRadius: 5.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.black.withOpacity(0.5),
                  inactiveFgColor: Colors.white.withOpacity(0.7),
                  totalSwitches: 2,
                  labels: ['Light', 'Dark'],
                  icons: const [
                    Icons.light_mode,
                    Icons.dark_mode,
                  ],
                  activeBgColors: const [
                    [Colors.blue],
                    [Colors.black]
                  ],
                  onToggle: (index) {
                    int currIndex =
                        themeProvider.themeMode == ThemeMode.light ? 0 : 1;
                    if (currIndex != index) {
                      themeProvider.toggleMode();
                    }
                    print(index);
                    print(currIndex);
                    print('switched to: $index');
                  },
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
