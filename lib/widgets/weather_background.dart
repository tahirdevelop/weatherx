import 'package:flutter/material.dart';
import 'package:weatherx/models/weather.dart';
import 'package:weatherx/models/weather_type.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart' as bg;

class WeatherBackground extends StatelessWidget {
  final Widget child;
  final Weather weather;

  final Map<WeatherType, bg.WeatherType> weatherBgMap = {
    WeatherType.mist: bg.WeatherType.hazy,
    WeatherType.snow: bg.WeatherType.heavySnow,
    WeatherType.clearSky: bg.WeatherType.sunny,
    WeatherType.rain: bg.WeatherType.lightRainy,
    WeatherType.fewClouds: bg.WeatherType.cloudy,
    WeatherType.brokenClouds: bg.WeatherType.foggy,
    WeatherType.thunderstorm: bg.WeatherType.thunder,
    WeatherType.showerRain: bg.WeatherType.middleRainy,
    WeatherType.scatteredClouds: bg.WeatherType.cloudy,
  };

  WeatherBackground(
    this.weather, {
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        bg.WeatherBg(
          width: size.width,
          height: size.height,
          weatherType: weatherBgMap[weather.type],
        ),
        child,
      ],
    );
  }
}
