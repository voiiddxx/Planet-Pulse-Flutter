import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planetpulse/models/fetchedmodel.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostService {
  Future<List<AllPost>> fetchPost(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
    List<AllPost> allpost = [];
    try {
      http.Response response = await http.get(
          Uri.parse("https://planet-pulse-bphm.onrender.com/get-all-post"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (Map<String, dynamic> i in data) {
          allpost.add(AllPost.fromJson(i));
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, "Some Error", Colors.red);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), Colors.red);
      }
    }

    return allpost;
  }
}
