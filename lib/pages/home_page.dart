import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../provider/weather_provider.dart';
import '../utils/location_helper_function.dart';

class Homepage extends StatelessWidget {
  static const String routeName = '/home_page';

  int once = 0;

  Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    if(once == 0){
      currentPosition.call().then((position) {
        provider.getResponse(position: position);
      });
      once++;
      print(once.toString());
      //once = true;
    }


    print(provider.weatherResponse!.main!.temp!);
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(onPressed: (){
            Provider.of<ThemeProvider>(context, listen: false).toggleMode();
            print('pressed');
          }, child: Text('CLICK'))
        ],
      ),
    );
  }
}
