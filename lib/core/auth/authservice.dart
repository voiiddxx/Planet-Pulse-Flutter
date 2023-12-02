// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/models/loginuser.dart';
import 'package:planetpulse/utils/res/snackbar.dart';

class AuthService {
  Future<void> createUserAccount(
      {required String username,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response response = await http.post(
          Uri.parse("https://planet-pulse-bphm.onrender.com/register"),
          body: jsonEncode(
              {username: username, email: email, password: password}),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushNamed(context, RoutesNames.homescreen);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response.body.toString())));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginService(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      LoginUser loginUser = LoginUser(username, password);
      http.Response response = await http.post(
          Uri.parse("https://planet-pulse-bphm.onrender.com/login"),
          body: loginUser.toJson(),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      if (response.statusCode == 200) {
        if (context.mounted) {
          print(response.body);
          Navigator.pushNamed(context, RoutesNames.homescreen);
        }
      } else {
        print(response.body);
        if (context.mounted) {
          showSnackBar(context, response.body.toString(), Colors.red);
        }
      }
    } catch (e) {
      print(e.toString());
      if (context.mounted) {
        showSnackBar(context, e.toString(), Colors.red);
      }
    }
  }
}
