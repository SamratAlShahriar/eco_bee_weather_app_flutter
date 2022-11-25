import 'package:eco_bee_weather_app_flutter/model/forecast_response_model.dart';
import 'package:eco_bee_weather_app_flutter/utils/constants.dart';
import 'package:eco_bee_weather_app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForecastSingleItemView extends StatelessWidget {
  final Forecast fModel;

  const ForecastSingleItemView({Key? key, required this.fModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.5, color: Colors.white),
        color: Colors.black.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 4),
                            color: Colors.white,
                          )),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            //Image.network(generateWeatherIconUrl(fModel.weather!.first.icon!)),
            SvgPicture.asset(
              getWeatherIconByCode(fModel.weather!.first.icon!),
              height: 48,
              width: 48,
            ),
            const SizedBox(height: 8,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/thermometer.svg',
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    RichText(text: TextSpan(
                      text: '${fModel.main?.temp}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      children: const [
                        TextSpan(text: symbolDegree),
                      ]
                    ), ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                      '${fModel.main?.humidity}%',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                      '${fModel.wind?.speed}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                      '${fModel.main?.pressure} hPa',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
