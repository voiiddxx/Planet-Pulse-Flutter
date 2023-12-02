// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  checkUserisPresentorNot(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        Future.delayed((const Duration(seconds: 2)));
        Navigator.pushNamed(context, RoutesNames.registerScreen);
      } else {
        http.Response response = await http.get(
            Uri.parse("https://pro-planet-server.onrender.com/get-curr-user"),
            headers: <String, String>{
              "Content-type": "application/json",
              "Accept": "application/json",
              "x-auth-token": token
            });
        print(response);
      }
    } catch (e) {
      return e;
    }
  }
}
