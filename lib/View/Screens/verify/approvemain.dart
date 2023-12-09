// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApprovemainScreen extends StatefulWidget {
  final dynamic ApproveUser;
  const ApprovemainScreen({
    super.key,
    required this.ApproveUser,
  });

  @override
  State<ApprovemainScreen> createState() => _ApprovemainScreenState();
}

class _ApprovemainScreenState extends State<ApprovemainScreen> {
  dynamic questions;
  Future<void> getuserQuestion() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      http.Response response = await http.get(
          Uri.parse(
              "https://planet-pulse-bphm.onrender.com/get-specific-user?username=${widget.ApproveUser['username']}"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      if (response.statusCode == 200) {
        setState(() {
          questions = jsonDecode(response.body);
        });
        // print(questions['ques'][0]['question']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getuserQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 39, 39, 39),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: NetworkImage(questions['userprofile']),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFont(
                      color: Colors.white,
                      text: questions['username'],
                      weight: FontWeight.w600,
                      size: 25),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFont(
                      color: const Color.fromARGB(255, 143, 143, 143),
                      text: questions['email'],
                      weight: FontWeight.w600,
                      size: 15),
                ],
              ),
            ),
            Container(
              height: 650,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white),
              width: double.infinity,
            ),
          ],
        ));
  }
}
