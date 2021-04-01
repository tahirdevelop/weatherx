import 'dart:developer';

import 'package:weatherx/services/notifications_service.dart';
import 'package:weatherx/services/weather_service.dart';
import 'package:workmanager/workmanager.dart';

void _callbackDispatcher() {
  Workmanager.executeTask((String task, Map<String, dynamic> inputData) async {
    return TaskManager.dispatcher(task, inputData);
  });
}

class TaskManager {
  static Future<void> init() async {
    await Workmanager.initialize(_callbackDispatcher, isInDebugMode: true);
    await _registerWeatherTask();
  }

  static Future<bool> dispatcher(
    String task,
    Map<String, dynamic> inputData,
  ) async {
    log("Running", name: "Task: $task");

    if (task == "weather_loader") {
      final notificationsService = NotificationsService();
      await WeatherService().loadForecastAndSave();
      await notificationsService.init();

      await notificationsService.showNotification(
          0, "WeatherX", "Forecast is updated !");
    }

    return Future.value(true);
  }

  static Future<void> _registerWeatherTask() {
    return Workmanager.registerPeriodicTask(
      "weather_loader_1",
      "weather_loader",
      constraints: Constraints(
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
        requiresBatteryNotLow: false,
        networkType: NetworkType.connected,
      ),
      frequency: Duration(hours: 24),
      initialDelay: Duration(hours: 24),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
  }
}
