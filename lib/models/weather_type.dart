enum WeatherType {
  rain,
  snow,
  mist,
  clearSky,
  fewClouds,
  showerRain,
  brokenClouds,
  thunderstorm,
  scatteredClouds,
}

extension WeatherTypeExt on WeatherType {
  static WeatherType fromCode(String code) {
    if (code.contains("01")) return WeatherType.clearSky;
    if (code.contains("02")) return WeatherType.fewClouds;
    if (code.contains("03")) return WeatherType.scatteredClouds;
    if (code.contains("04")) return WeatherType.brokenClouds;
    if (code.contains("09")) return WeatherType.showerRain;
    if (code.contains("10")) return WeatherType.rain;
    if (code.contains("11")) return WeatherType.thunderstorm;
    if (code.contains("13")) return WeatherType.snow;
    if (code.contains("50")) return WeatherType.mist;
    return WeatherType.clearSky;
  }

  String toLocalString() {
    return {
          WeatherType.clearSky: "Clear sky",
          WeatherType.fewClouds: "Few clouds",
          WeatherType.scatteredClouds: "Scattered clouds",
          WeatherType.brokenClouds: "Broken clouds",
          WeatherType.showerRain: "Shower rain",
          WeatherType.rain: "Rain",
          WeatherType.snow: "Snow",
          WeatherType.mist: "Mist",
          WeatherType.thunderstorm: "Thunderstorm",
        }[this] ??
        "";
  }
}
