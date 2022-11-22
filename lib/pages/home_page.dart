import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../provider/weather_provider.dart';
import '../utils/location_helper_function.dart';

class Homepage extends StatefulWidget {
  static const String routeName = '/home_page';

  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int once = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    if (once == 0) {
      // currentPosition.call().then((position) {
      //   provider.getResponse(position: position);
      // });
      once++;
      print(once.toString());
      super.didChangeDependencies();
    }
  }
    @override
    Widget build(BuildContext context) {
      print('build called');

    //print(provider.weatherResponse!.main!.temp!);
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleMode();
                print('pressed');
              },
              child: Text('CLICK'))
        ],
      ),
    );
  }
}
