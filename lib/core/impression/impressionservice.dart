import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImpressionService {
  Future<void> LikeThePost({required String postid}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      http.Response response = await http.post(
          Uri.parse("https://planet-pulse-bphm.onrender.com/like-user-post"),
          body: jsonEncode({'postid': postid}),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      print(response.body);
    } catch (e) {
      throw e.toString();
    }
  }
}
