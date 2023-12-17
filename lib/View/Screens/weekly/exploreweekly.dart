// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/Screens/weekly/submittask.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

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
File? taskSubmitImage;

class _ExploreWeeklyTraskState extends State<ExploreWeeklyTrask> {
  clickImage() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.camera);
      if (result != null) {
        final tempimage = File(result.path);
        setState(() {
          taskSubmitImage = tempimage;
        });

        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SubmitTaskScreen(
              imagetosubmit: taskSubmitImage!,
              task: taskData!,
            );
          }));
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, "Please Select Image", Colors.red);
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }

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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              taskData == null
                  ? Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 33, 33, 33),
                      highlightColor: Colors.black,
                      child: Container(
                        height: h * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    )
                  : Container(
                      height: h * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(taskData['task_image']),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.yellow[100],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomFont(
                                    color: GlobalColor.headingcolor,
                                    text: "Refrence Image",
                                    weight: FontWeight.w500,
                                    size: h * 0.012),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomFont(
                                      color: GlobalColor.headingcolor,
                                      text: "Task Deadline: 1 Week",
                                      weight: FontWeight.w500,
                                      size: h * 0.012),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : CustomFont(
                                color: GlobalColor.headingcolor,
                                text: taskData['task_title'],
                                weight: FontWeight.w700,
                                size: h * 0.020),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomFont(
                                      color: GlobalColor.headingcolor,
                                      text: "Overview",
                                      weight: FontWeight.w500,
                                      size: h * 0.012),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.080,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : CustomFont(
                                color: GlobalColor.subtitlecolor,
                                text:
                                    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Qui dicta minus molestiae vel beatae natus eveniet ratione temporibus aperiam harum alias officiis assumenda officia quibusdam deleniti eos cupiditate dolore doloribus >Ad dolore dignissimos asperiores dicta facere optio quod commodi nam tempore recusandae. Rerum sed nulla eum vero expedita ex delectus voluptates rem at neque quos facere sequi unde optio aliquam!</p><p>Tenetur quod quidem in voluptatem corporis dolorum dicta sit pariatur porro quaerat autem ipsam odit quam beatae tempora quibusdam illum! Modi velit odio nam nulla unde amet odit pariatur at!</p>",
                                weight: FontWeight.w400,
                                size: h * 0.016),
                        const SizedBox(
                          height: 20,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : CustomFont(
                                color: GlobalColor.headingcolor,
                                text: "Task Guidlines*",
                                weight: FontWeight.w700,
                                size: h * 0.016),
                        const SizedBox(
                          height: 25,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  SizedBox(
                                    width: w * 0.7,
                                    child: CustomFont(
                                        color: GlobalColor.subtitlecolor,
                                        text:
                                            "Complete the task within the given timeline",
                                        weight: FontWeight.w400,
                                        size: h * 0.014),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  SizedBox(
                                    width: w * 0.7,
                                    child: CustomFont(
                                        color: GlobalColor.subtitlecolor,
                                        text:
                                            "Submit image taking refrence from refrence image",
                                        weight: FontWeight.w400,
                                        size: h * 0.014),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  SizedBox(
                                    width: w * 0.7,
                                    child: CustomFont(
                                        color: GlobalColor.subtitlecolor,
                                        text:
                                            "If any fake proofs will found , then your account got permanentlty banned",
                                        weight: FontWeight.w400,
                                        size: h * 0.014),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  SizedBox(
                                    width: w * 0.7,
                                    child: CustomFont(
                                        color: GlobalColor.subtitlecolor,
                                        text: "Read the task detail carefully",
                                        weight: FontWeight.w400,
                                        size: h * 0.014),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  SizedBox(
                                    width: w * 0.7,
                                    child: CustomFont(
                                        color: GlobalColor.subtitlecolor,
                                        text:
                                            "Duplicate sumbmission of task will lead to deduction of pro planet coins",
                                        weight: FontWeight.w400,
                                        size: h * 0.014),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomFont(
                                      color: GlobalColor.headingcolor,
                                      text: "Points to be remember",
                                      weight: FontWeight.w500,
                                      size: h * 0.012),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: h * 0.020,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : CustomFont(
                                color: GlobalColor.subtitlecolor,
                                text:
                                    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Qui dicta minus molestiae vel beatae natus eveniet ratione temporibus aperiam harum alias officiis assumenda officia quibusdam deleniti eos cupiditate dolore doloribus >Ad dolore dignissimos",
                                weight: FontWeight.w400,
                                size: h * 0.016),
                        const SizedBox(
                          height: 15,
                        ),
                        taskData == null
                            ? Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 204, 204, 204),
                                highlightColor: Colors.white,
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              )
                            : SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalColor.primarycolor,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    clickImage();
                                  },
                                  child: CustomFont(
                                      color: Colors.white,
                                      text: "Submit task",
                                      weight: FontWeight.w500,
                                      size: h * 0.015),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
