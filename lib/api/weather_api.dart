import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherApi {
  static String _apiKey = "eb42a51f9641f80702467bf51b8781f3";
  static Uri baseUrl = Uri.parse("https://api.openweathermap.org/");

  static Future<Map<String, dynamic>> fetchForecast() async {
    final response = await http.get(
      baseUrl.replace(
        path: "/data/2.5/onecall",
        queryParameters: {
          "appid": _apiKey,
          "units": "metric",
          "lat": "48.319630",
          "lon": "25.941481",
          "exclude": "minutely,alerts,current",
        },
      ),
    );

    return response.statusCode == 200
        ? Map<String, dynamic>.from(jsonDecode(response.body))
        : null;
  }
}
