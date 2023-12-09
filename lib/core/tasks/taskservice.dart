// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:planetpulse/models/approveweeklyresponse.dart';
import 'package:planetpulse/models/fetchedmodel.dart';
import 'package:planetpulse/models/submittaskmodel.dart';
import 'package:planetpulse/models/taskmode.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TaskService {
  Future<void> submitTask(
      {required dynamic task,
      required dynamic image,
      required String extradetail,
      required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      // ignore: unused_local_variable
      final user = Provider.of<AuthProvider>(context, listen: false).user;
      User submituser = User(
          username: user.username,
          userprofile: user.userprofile,
          email: user.email,
          proPlanetLevel: user.pro_planet_level,
          password: user.password,
          posts: [],
          proPlanetRating: user.pro_planet_rating,
          totalCompletedTask: user.total_completed_task,
          ques: user.ques,
          id: user.id,
          v: 5);

      SubmittaskModel submittaskModel = SubmittaskModel(
          user: submituser, task: task, image: image, extradetail: extradetail);

      http.Response response = await http.post(
        Uri.parse("https://planet-pulse-bphm.onrender.com/register-response"),
        body: submittaskModel.toJson(),
        headers: <String, String>{
          "Content-type": "application/json",
          "Accept": "application/json",
          'x-auth-token': token!
        },
      );
      print(response.body);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> AssingTask(
      {required String task_title,
      required String task_detail,
      required String task_guidlines,
      required String task_image,
      required String task_level}) async {
    try {
      TaskModel taskModel = TaskModel(
          task_title: task_title,
          task_detail: task_detail,
          task_guidlines: task_guidlines,
          task_image: task_image,
          task_level: task_level);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      http.Response response = await http.post(
          Uri.parse("https://planet-pulse-bphm.onrender.com/assign-task"),
          body: taskModel.toJson(),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> approveWeeklyTasks(
      {required String userid,
      required String task_level,
      required String submitid}) async {
    try {
      ApproveWeeklyModel approveWeeklyModel = ApproveWeeklyModel(
          userid: userid, task_level: task_level, submitid: submitid);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.post(
          Uri.parse(
              "https://planet-pulse-bphm.onrender.com/approve-weekly-task"),
          body: approveWeeklyModel.toJson(),
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
