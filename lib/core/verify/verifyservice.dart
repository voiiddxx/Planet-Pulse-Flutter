import 'package:flutter/material.dart';
import 'package:planetpulse/models/applyverifymodel.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VerificationService {
  Future<void> submitVerification(
      {required String verifytask,
      required String verifyimage,
      required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      ApplyVerifyModal applyVerifyModal =
          ApplyVerifyModal(verifytask: verifytask, verifyimage: verifyimage);
      if (verifyimage != '' && verifytask != '') {
        http.Response response = await http.post(Uri.parse(""),
            body: applyVerifyModal.toJson(),
            headers: <String, String>{
              "Content-type": "application/json",
              "Accept": "application/json",
              'x-auth-token': token!
            });
        if (response.statusCode == 200) {
          print(response.body);
        } else {
          print("Some Error arrised");
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), Colors.red);
      }
    }
  }
}
