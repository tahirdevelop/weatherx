import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  NotificationDetails _channel;
  FlutterLocalNotificationsPlugin _flp = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final ios = IOSInitializationSettings();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: ios);

    final androidChannel = AndroidNotificationDetails(
      'weatherx_channel',
      'weatherx channel',
      'weatherx channel for notifications',
      priority: Priority.high,
      importance: Importance.max,
    );

    final iosChannel = IOSNotificationDetails();

    await _flp.initialize(settings);

    _channel = NotificationDetails(iOS: iosChannel, android: androidChannel);
  }

  Future<void> showNotification(
    int id,
    String title,
    String body, {
    String payload,
  }) {
    return _flp.show(0, title, body, _channel, payload: payload);
  }
}
