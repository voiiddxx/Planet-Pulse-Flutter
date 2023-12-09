import 'package:flutter/material.dart';
import 'package:planetpulse/models/applyverifymodel.dart';
import 'package:planetpulse/models/approveverifymodel.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VerificationService {
  Future<void> submitVerification(
      {required String question,
      required String quesImage,
      required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      ApplyVerifyModal applyVerifyModal =
          ApplyVerifyModal(question: question, quesImage: quesImage);
      if (question != '' && quesImage != '') {
        http.Response response = await http.post(
            Uri.parse("https://planet-pulse-bphm.onrender.com/post-ques"),
            body: applyVerifyModal.toJson(),
            headers: <String, String>{
              "Content-type": "application/json",
              "Accept": "application/json",
              'x-auth-token': token!
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), Colors.red);
      }
    }
  }

  Future<void> approveResponse(
      {required dynamic id, required dynamic postid}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      ApproveVerifyModel approveVerifyModel =
          ApproveVerifyModel(id: id, postid: postid);
      http.Response response = await http.post(
          Uri.parse(
              "https://pro-planet-server.onrender.com/approve-verify-req"),
          body: approveVerifyModel.toJson(),
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
