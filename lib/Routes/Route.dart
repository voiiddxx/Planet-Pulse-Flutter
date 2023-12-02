import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/Screens/Auth/register.dart';
import 'package:planetpulse/View/Screens/home/home.dart';
import 'package:planetpulse/View/Screens/start/splash.dart';

Route<dynamic> onGenreateSetting(RouteSettings settings) {
  switch (settings.name) {
    case RoutesNames.splashScreen:
      return MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      });
    case RoutesNames.homescreen:
      return MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      });
    case RoutesNames.registerScreen:
      return MaterialPageRoute(builder: (context) {
        return const RegisterScreen();
      });

    default:
      return MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      });
  }
}
