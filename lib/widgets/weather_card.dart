import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherx/models/weather.dart';
import 'package:weatherx/utils/size_utils.dart';
import 'package:weatherx/widgets/svg_icon.dart';
import 'package:weatherx/models/weather_type.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

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

  const WeatherCard(this.weather, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Color.fromRGBO(184, 210, 228, 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DateInfo(weather.date),
          SizedBox(height: px(10, context)),
          _Temperature(weather.temperature.toInt()),
          SizedBox(height: px(1.5, context)),
          Text(
            weather.type.toLocalString(),
            style: textStyle.copyWith(fontSize: px(8, context)),
          ),
          SizedBox(height: px(10, context)),
          _WeatherInfo(
            wind: weather.wind,
            humidity: weather.humidity,
          )
        ],
      ),
    );
  }
}

class _DateInfo extends StatelessWidget {
  final DateTime date;
  const _DateInfo(this.date, {Key key}) : super(key: key);

  DateTime _toDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  bool _isSameDate(DateTime dateX, DateTime dateY) {
    return _toDay(dateX) == _toDay(dateY);
  }

  @override
  Widget build(BuildContext context) {
    String dateString = "${date.day} ${DateFormat.MMMM().format(date)}";

    if (_isSameDate(DateTime.now(), date)) {
      dateString = "Today, $dateString";
    }
    return Text(
      dateString,
      style: WeatherCard.textStyle.copyWith(fontSize: px(6, context)),
    );
  }
}

class _Temperature extends StatelessWidget {
  final int temperature;
  const _Temperature(this.temperature, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      " $temperature°",
      style: TextStyle(
        height: 1,
        fontSize: px(30, context),
        color: Colors.transparent,
        shadows: [
          Shadow(
            blurRadius: 30,
            offset: Offset(-15, 15),
            color: Colors.black.withOpacity(.4),
          ),
          Shadow(
            offset: Offset(.1, 0),
            color: Colors.white,
          ),
          Shadow(
            blurRadius: 7,
            offset: Offset(-1, 3),
            color: Colors.black.withOpacity(.17),
          ),
        ],
      ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  final num wind;
  final num humidity;

  const _WeatherInfo({this.wind, this.humidity, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            SvgIcon("wind", height: px(8, context)),
            SizedBox(height: px(7, context)),
            SvgIcon("hum", height: px(8, context)),
          ],
        ),
        SizedBox(width: px(7, context)),
        Column(
          children: [
            Text(
              "|",
              style: WeatherCard.textStyle.copyWith(fontSize: px(5, context)),
            ),
            SizedBox(height: px(7, context)),
            Text(
              "|",
              style: WeatherCard.textStyle.copyWith(fontSize: px(5, context)),
            ),
          ],
        ),
        SizedBox(width: px(7, context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${(wind * 3.6).toInt()} km/h",
              style: WeatherCard.textStyle.copyWith(fontSize: px(6, context)),
            ),
            SizedBox(height: px(6, context)),
            Text(
              "$humidity %",
              style: WeatherCard.textStyle.copyWith(fontSize: px(6, context)),
            ),
          ],
        ),
      ],
    );
  }
}
