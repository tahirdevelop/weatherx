import 'package:get_it/get_it.dart';
import 'package:weatherx/services/weather_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<WeatherService>(WeatherService());
}
