import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherx/core/task_manager.dart';
import 'package:weatherx/screens/home/view/home_screen.dart';
import 'package:weatherx/services/weather_service.dart';
import 'package:weatherx/widgets/splash_screen_wrapper.dart';

import 'core/get_it.dart';
import 'screens/home/view/home_screen.dart';

class App extends StatelessWidget {
  final Future<void> setuping = setup();

  App({Key key}) : super(key: key);

  static Future<void> setup() async {
    await setupLocator();
    await Firebase.initializeApp();

    if (Platform.isAndroid) await TaskManager.init();
    if (Platform.isIOS) await getIt<WeatherService>().loadForecastAndSave();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setuping,
      builder: (context, snapshot) {
        return MaterialApp(
          theme: ThemeData(textTheme: GoogleFonts.overpassTextTheme()),
          home: SplashScreenWrapper(
            child: HomeScreen(),
            duration: Duration(seconds: 5),
          ),
        );
      },
    );
  }
}
