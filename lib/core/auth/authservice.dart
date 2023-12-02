// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  createUserAccount(
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
      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
