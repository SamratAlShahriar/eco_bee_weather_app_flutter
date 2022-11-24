import 'package:eco_bee_weather_app_flutter/custom_widget/forecast_view_single_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../menu/main_drawer.dart';
import '../provider/settings_provider.dart';
import '../provider/theme_provider.dart';
import '../provider/weather_provider.dart';
import '../utils/constants.dart';
import '../utils/location_helper_function.dart';
import '../utils/utils.dart';

class Homepage extends StatefulWidget {
  static const String routeName = '/';

  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late WeatherProvider weatherProvider;
  late ThemeProvider themeProvider;
  late SettingsProvider settingsProvider;
  bool firstTime = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (firstTime) {
      weatherProvider = Provider.of<WeatherProvider>(context);
      themeProvider = Provider.of<ThemeProvider>(context);
      settingsProvider = Provider.of<SettingsProvider>(context);
      _getCurrentPositionWeatherData();
      firstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build called');
    return Scaffold(
      drawer: const Drawer(
        child: MainDrawer(),
      ),
      appBar: AppBar(
        title: Text(
            "${weatherProvider.weatherResponse?.name ?? ''}, ${weatherProvider.weatherResponse?.sys?.country ?? ''}"),
        actions: [
          IconButton(
              onPressed: () {
                _getCurrentPositionWeatherData();
              },
              icon: const Icon(Icons.my_location)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: weatherProvider.hasDataLoaded
          ? SingleChildScrollView(
              child: Column(
                children: [
                  _sectionCurrentWeather(),
                  _sectionForcastWeather(),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
    );
  }

  void _getCurrentPositionWeatherData() {
    currentPosition().then((position) {
      weatherProvider.setNewLatLon(
          lat: position.latitude, lon: position.longitude);
      weatherProvider.getResponses();
    });
  }

  Widget _sectionCurrentWeather() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    getFormattedCurrentTime(pattern: dfEEEyyyyMMdd),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getFormattedCurrentTime(pattern: df12Hour),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: weatherProvider.weatherResponse?.main?.temp
                                ?.toStringAsFixed(1) ??
                            '0',
                        style: const TextStyle(
                            fontSize: 52.0, fontWeight: FontWeight.w200),
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(-4, -8),
                              child: const Text(
                                symbolDegree,
                                style: TextStyle(
                                    fontSize: 44, fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(-6, -28),
                              child: Text(
                                weatherProvider.unitSymbol,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              Column(
                children: [
                  Image.network(
                    generateWeatherIconUrl(
                        weatherProvider.weatherResponse!.weather!.first!.icon!),
                    height: 48,
                    width: 48,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    weatherProvider
                            .weatherResponse?.weather?.first.description ??
                        '',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Max : ${weatherProvider.weatherResponse?.main?.tempMax ?? 0}'),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                            'Min : ${weatherProvider.weatherResponse?.main?.tempMin ?? 0}'),
                      ],
                    ),
                    Text(
                        'Wind : ${weatherProvider.weatherResponse?.wind?.speed ?? 0}')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionForcastWeather() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      height: 300,
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weatherProvider.forecastResponse?.list?.length ?? 0,
        itemBuilder: (context, index) {
          final fItem = weatherProvider.forecastResponse?.list![index];
          return ForecastSingleItemView(
            fModel: fItem!,
          );
        },
      ),
    );
  }
}
