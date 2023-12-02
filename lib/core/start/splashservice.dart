// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  checkUserisPresentorNot(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      http.Response response = await http.get(
          Uri.parse("https://pro-planet-server.onrender.com/get-curr-user"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            "x-auth-token": token!
          });
      print(response);
    } catch (e) {
      return e;
    }
  }
}
