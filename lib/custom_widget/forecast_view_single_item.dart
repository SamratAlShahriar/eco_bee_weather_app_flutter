import 'package:eco_bee_weather_app_flutter/model/forecast_response_model.dart';
import 'package:eco_bee_weather_app_flutter/utils/constants.dart';
import 'package:eco_bee_weather_app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class ForecastSingleItemView extends StatelessWidget {
  final Forecast fModel;

  const ForecastSingleItemView({Key? key, required this.fModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.black.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getFormattedDate(fModel.dt!, pattern: dfMMdd),
                ),
                Text(
                  getFormattedDate(fModel.dt!, pattern: df12HourWithWeekDay),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      14,
                      (index) => Container(
                            width: 4,
                            height: 1.3,
                            margin: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 4),
                            color: Colors.white,
                          )),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Temp : ${fModel.main?.temp}',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Feels like : ${fModel.main?.feelsLike}',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Humidity : ${fModel.main?.humidity}%',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Pressure : ${fModel.main?.pressure}',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
