// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/models/loginuser.dart';
import 'package:planetpulse/models/user.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      username: '',
      userprofile: '',
      email: '',
      pro_planet_level: 0,
      password: '',
      post: [],
      pro_planet_rating: 0,
      total_completed_task: 0,
      category: '',
      ques: []);

  User get user => _user;

  Future<void> loginUser(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      LoginUser loginUser = LoginUser(username, password);
      http.Response response = await http.post(
          Uri.parse("https://planet-pulse-bphm.onrender.com/login"),
          body: loginUser.toJson(),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        await preferences.setString('x-auth-token', userData['token']);
        _user = User(
            id: userData['_id'],
            username: userData['username'],
            userprofile: userData['userprofile'],
            email: userData['email'],
            password: userData['password'],
            pro_planet_level: userData['pro_planet_level'],
            post: userData['post'],
            pro_planet_rating: userData['pro_planet_rating'],
            total_completed_task: userData['total_completed_task'],
            category: userData['category'],
            ques: userData['ques']);
        if (context.mounted) {
          Navigator.pushNamed(context, RoutesNames.homescreen);
        }
      } else {
        if (context.mounted) {
          Navigator.pushNamed(context, RoutesNames.loginScreen);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), Colors.red);
      }
    }
  }

  Future<void> getCurrUser(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('x-auth-token');

      if (token == null) {
        Navigator.pushNamed(context, RoutesNames.loginScreen);
      } else {
        http.Response response = await http.get(
            Uri.parse("https://planet-pulse-bphm.onrender.com/get-curr-user"),
            headers: <String, String>{
              "Content-type": "application/json",
              "Accept": "application/json",
              'x-auth-token': token
            });

        if (response.statusCode == 200) {
          Map<String, dynamic> userData = jsonDecode(response.body);
          _user = User(
              id: userData['_id'],
              username: userData['username'],
              userprofile: userData['userprofile'],
              email: userData['email'],
              password: userData['password'],
              pro_planet_level: userData['pro_planet_level'],
              post: userData['post'],
              pro_planet_rating: userData['pro_planet_rating'],
              total_completed_task: userData['total_completed_task'],
              category: userData['category'],
              ques: userData['ques']);

          if (context.mounted) {
            if (userData['category'] == 'admin') {
              Navigator.pushNamed(context, RoutesNames.adminbottombar);
            } else {
              Navigator.pushNamed(context, RoutesNames.homescreen);
            }
          }
        } else {
          if (context.mounted) {
            Navigator.pushNamed(context, RoutesNames.loginScreen);
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), Colors.red);
      }
    }
  }
}
