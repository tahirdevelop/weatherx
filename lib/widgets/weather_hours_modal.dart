import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherx/models/weather.dart';
import 'package:weatherx/utils/size_utils.dart';

Future<void> showWeatherHoursModal({
  BuildContext context,
  List<Weather> hoursWeather,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    builder: (context) => WeatherHoursModal(hoursWeather: hoursWeather),
  );
}

class WeatherHoursModal extends StatelessWidget {
  final List<Weather> hoursWeather;

  static final TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    shadows: [
      Shadow(
        blurRadius: 5,
        offset: Offset(-5, 5),
        color: Colors.black.withOpacity(.2),
      ),
    ],
  );

  void _handleClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  const WeatherHoursModal({this.hoursWeather, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: px(15, context)),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                onTap: () => _handleClose(context),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
            ),
            SizedBox(height: px(4, context)),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: hoursWeather.length,
                itemBuilder: (context, idx) {
                  final Weather weather = hoursWeather[idx];

                  return Column(
                    children: [
                      Divider(height: 1, color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${weather.date.hour.toString().padLeft(2, '0')}:00",
                            style: textStyle.copyWith(fontSize: px(6, context)),
                          ),
                          SizedBox(
                            child: weather.icon,
                            height: px(25, context),
                          ),
                          Text(
                            "${weather.temperature}°",
                            style: textStyle.copyWith(fontSize: px(6, context)),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
