import 'package:eco_bee_weather_app_flutter/custom_widget/forecast_view_single_item.dart';
import 'package:eco_bee_weather_app_flutter/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Stack(
      children: [
        Image.asset(
          weatherProvider.hasDataLoaded
              ? getAppBgImageByWeatherCode(
                  weatherProvider.weatherResponse!.weather!.first.icon!)
              : 'assets/images/default.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          drawer: const Drawer(
            child: MainDrawer(),
          ),
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.25),
            title: weatherProvider.hasDataLoaded
                ? Text(
                    "${weatherProvider.weatherResponse?.name ?? ''}, ${weatherProvider.weatherResponse?.sys?.country ?? ''}")
                : Text('Eco Bee'),
            actions: [
              IconButton(
                  onPressed: () {
                    _getCurrentPositionWeatherData();
                  },
                  icon: const Icon(Icons.my_location)),
              IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: _CitySearchDelegate(),
                    ).then((city) async {
                      if (city != null && city.isNotEmpty) {
                        final loc = await convertAddressToLocation(city);
                        if (loc != null) {
                          weatherProvider.setNewLatLon(
                              lat: loc.latitude, lon: loc.longitude);
                          weatherProvider.getResponses();
                        }
                      }
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: weatherProvider.hasDataLoaded
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      _sectionCurrentWeather(),
                      _sectionCurrentWeatherOthersInfo(),
                      _sectionForecastWeather(),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ],
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Feels like : ',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: weatherProvider.weatherResponse?.main?.temp
                                    ?.toStringAsFixed(1) ??
                                '0',
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                            children: [
                              TextSpan(text: symbolDegree, children: [
                                TextSpan(text: weatherProvider.unitSymbol),
                              ]),
                            ]),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  SvgPicture.asset(
                    getWeatherIconByCode(
                        weatherProvider.weatherResponse!.weather!.first!.icon!),
                    height: 70,
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
        ],
      ),
    );
  }

  Widget _sectionCurrentWeatherOthersInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      height: 250,
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(text: '(min) ', children: [
                    TextSpan(
                        text:
                            '${weatherProvider.weatherResponse?.main?.tempMin}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        children: const [
                          TextSpan(text: symbolDegree),
                        ]),
                  ]),
                ),
                const SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  'assets/icons/thermometer.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                RichText(
                  text: TextSpan(
                      text: '${weatherProvider.weatherResponse?.main?.tempMax}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      children: const [
                        TextSpan(
                            text: symbolDegree,
                            children: [TextSpan(text: ' (max)')]),
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/humidity.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '${weatherProvider.weatherResponse?.main?.humidity}%',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/wind.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '${weatherProvider.weatherResponse?.wind?.speed}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/pressure.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '${weatherProvider.weatherResponse?.main?.pressure} hPa',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/sunrise.svg',
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      getFormattedDate(
                          weatherProvider.weatherResponse!.sys!.sunrise!,
                          pattern: df12Hour),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/sunset.svg',
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      getFormattedDate(
                          weatherProvider.weatherResponse!.sys!.sunset!,
                          pattern: df12Hour),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _sectionForecastWeather() {
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

class _CitySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              close(context, query);
            },
            title: Text(
              query,
              style: TextStyle(color: Colors.black87),
            ),
            leading: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredList = query.isEmpty
        ? cities
        : cities
            .where((city) => city.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];
          return ListTile(
            onTap: () {
              query = item;
              close(context, query);
            },
            title: Text(
              item,
              style: TextStyle(color: Colors.black87),
            ),
          );
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ecoBeeThemeLight.copyWith(
      textTheme: TextTheme().apply(
        bodyColor: Colors.black87,
      ),
    );
  }
}
