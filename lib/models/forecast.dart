import 'package:weatherx/models/weather.dart';

class Forecast {
  final List<Weather> days;
  final List<Weather> hours;

  const Forecast({
    this.days = const [],
    this.hours = const [],
  });

  List<Weather> findHoursOfDay(Weather dayWeather) {
    return hours.where((hourWeather) {
      final DateTime aDate = DateTime(
        hourWeather.date.year,
        hourWeather.date.month,
        hourWeather.date.day,
      );

      final DateTime bDate = DateTime(
        dayWeather.date.year,
        dayWeather.date.month,
        dayWeather.date.day,
      );

      return aDate == bDate;
    }).toList();
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      days: List<Weather>.from(map['daily']?.map((x) => Weather.fromMap(x))),
      hours: List<Weather>.from(map['hourly']?.map((x) => Weather.fromMap(x))),
    );
  }
}
