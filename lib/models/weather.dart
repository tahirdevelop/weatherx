import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherx/models/weather_type.dart';

class Weather {
  final num wind;
  final num humidity;
  final DateTime date;
  final num temperature;
  final String iconCode;
  final WeatherType type;

  const Weather({
    this.wind,
    this.date,
    this.type,
    this.iconCode,
    this.humidity,
    this.temperature,
  });

  SvgPicture get icon {
    return SvgPicture.asset("assets/weather/$iconCode.svg");
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      wind: map['wind_speed'],
      humidity: map['humidity'],
      iconCode: map["weather"][0]["icon"],
      date: DateTime.fromMillisecondsSinceEpoch(map["dt"] * 1000),
      type: WeatherTypeExt.fromCode(map["weather"][0]["icon"]),
      temperature: map["temp"] is num ? map["temp"] : map["temp"]["max"],
    );
  }
}
