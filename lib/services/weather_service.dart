import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:weatherx/api/weather_api.dart';
import 'package:weatherx/models/forecast.dart';

class WeatherService {
  Future<File> _getDataFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data/weather.json");
  }

  Future<void> loadForecastAndSave() async {
    final Map<String, dynamic> forecast = await WeatherApi.fetchForecast();
    log("Fetched data to file.", name: "WeatherService");
    if (forecast != null) await saveData(forecast);
  }

  Future<void> saveData(Map<String, dynamic> data) async {
    final String stringData = jsonEncode(data);
    final File file = await _getDataFile();

    if (await file.exists()) {
      await file.delete();
    }

    await file.create(recursive: true);
    await file.writeAsString(stringData);
    log("Saved data to file.", name: "WeatherService");
  }

  Future<Forecast> getForecast() async {
    final File file = await _getDataFile();

    if (!(await file.exists())) {
      await loadForecastAndSave();
    }

    final String dataString = await file.readAsString();
    return Forecast.fromMap(jsonDecode(dataString) as Map<String, dynamic>);
  }
}
