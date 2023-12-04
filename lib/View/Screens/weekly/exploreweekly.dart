// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreWeeklyTrask extends StatefulWidget {
  final String tasklevel;
  const ExploreWeeklyTrask({
    super.key,
    required this.tasklevel,
  });

  @override
  State<ExploreWeeklyTrask> createState() => _ExploreWeeklyTraskState();
}

dynamic taskData = {};

class _ExploreWeeklyTraskState extends State<ExploreWeeklyTrask> {
  void getTaskCategoryData({required String category}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.get(
          Uri.parse(
              "https://planet-pulse-bphm.onrender.com/get-category-task?task_level=$category"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      setState(() {
        taskData = jsonDecode(response.body);
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskCategoryData(category: widget.tasklevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        appBar: AppBar(
          backgroundColor: GlobalColor.primarycolor,
          elevation: 0,
          leading: const Icon(
            Icons.all_inclusive_rounded,
            color: Colors.white,
            size: 20,
          ),
          actions: const [
            Icon(
              Icons.logout_sharp,
              color: Colors.white,
              size: 24,
            ),
            Icon(
              Icons.logout_sharp,
              color: Color.fromARGB(0, 255, 255, 255),
              size: 20,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: const Center(
                    child: CustomFont(
                        color: Colors.black,
                        text: "Task Detail",
                        weight: FontWeight.w400,
                        size: 16),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFont(
                            color: Colors.black,
                            text: taskData['task_title'],
                            weight: FontWeight.w500,
                            size: 18),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomFont(
                            color: Colors.black,
                            text: taskData['task_detail'],
                            weight: FontWeight.w300,
                            size: 16),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomFont(
                            color: Colors.green,
                            text: "Task Guidlines",
                            weight: FontWeight.w800,
                            size: 18),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomFont(
                            color: Colors.black,
                            text: taskData['task_guidlines'],
                            weight: FontWeight.w300,
                            size: 16),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    taskData['task_image'],
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 34, 34, 34)),
                              onPressed: () {},
                              child: const CustomFont(
                                  color: Colors.white,
                                  text: "SUbmit Task",
                                  weight: FontWeight.w500,
                                  size: 15)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
