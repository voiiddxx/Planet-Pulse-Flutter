// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:planetpulse/models/eventmodel.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventService {
  Future<dynamic> postEvent(
      {required BuildContext context,
      required String event_title,
      required String event_details,
      required String event_organization,
      required String event_date,
      required String event_link,
      required String event_image,
      required String event_location,
      required String additinols_details}) async {
    try {
      EventModel eventModel = EventModel(
        event_title: event_title,
        event_details: event_details,
        event_organization: event_organization,
        event_date: event_date,
        event_link: event_link,
        event_image: event_image,
        event_location: event_location,
        additinols_details: additinols_details,
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.post(
          Uri.parse("https://planet-pulse-bphm.onrender.com/add-event"),
          body: eventModel.toJson(),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      if (response.statusCode != 200) {
        showSnackBar(context, response.body, Colors.red);
      } else {
        return response.statusCode;
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      throw e.toString();
    }
  }
}
