import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/Screens/start/splash.dart';

Route<dynamic> onGenreateSetting(RouteSettings settings) {
  switch (settings.name) {
    case RoutesNames.splashScreen:
      return MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      });

    default:
      return MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      });
  }
}
