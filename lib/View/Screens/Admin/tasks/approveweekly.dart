import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planetpulse/core/tasks/taskservice.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:http/http.dart' as http;
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ApproveWeeklyTaskScreen extends StatefulWidget {
  const ApproveWeeklyTaskScreen({super.key});

  @override
  State<ApproveWeeklyTaskScreen> createState() =>
      _ApproveWeeklyTaskScreenState();
}

class _ApproveWeeklyTaskScreenState extends State<ApproveWeeklyTaskScreen> {
  bool isLoading = false;

  final TaskService taskService = TaskService();
  dynamic tasks;
  Future<void> getAllTask() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.get(
          Uri.parse("https://planet-pulse-bphm.onrender.com/get-responses"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });

      if (response.statusCode == 200) {
        setState(() {
          tasks = jsonDecode(response.body);
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getAllTask();
  }

  approveWeeklyTaskNow(
      {required String userid,
      required String task_level,
      required String submitid}) async {
    setState(() {
      isLoading = true;
    });
    dynamic data = await taskService.approveWeeklyTasks(
        userid: userid,
        task_level: task_level,
        submitid: submitid,
        context: context);
    setState(() {
      isLoading = false;
    });
    if (data == 200) {
      showSnackBar(context, "Task Approved", Colors.red);
      getAllTask();
    }
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks == null ? 2 : tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
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
                          tasks == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 212, 212, 212),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ))
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(tasks[index]['image']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tasks == null
                                  ? Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                          255, 212, 212, 212),
                                      highlightColor: Colors.white,
                                      child: Container(
                                        height: 20,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : CustomFont(
                                      color: GlobalColor.headingcolor,
                                      text:
                                          "Task: ${tasks[index]['task']['task_title']}",
                                      weight: FontWeight.w600,
                                      size: 18),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  tasks == null
                                      ? Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                              255, 212, 212, 212),
                                          highlightColor: Colors.white,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      tasks[index]['user']
                                                          ['userprofile']),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      tasks == null
                                          ? Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  255, 212, 212, 212),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                height: 10,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : CustomFont(
                                              color: GlobalColor.headingcolor,
                                              text: tasks[index]['user']
                                                  ['username'],
                                              weight: FontWeight.w600,
                                              size: 18),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      tasks == null
                                          ? Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  255, 212, 212, 212),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                height: 10,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : CustomFont(
                                              color: const Color.fromARGB(
                                                  255, 52, 52, 52),
                                              text: tasks[index]['user']
                                                  ['email'],
                                              weight: FontWeight.w300,
                                              size: 12),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              tasks == null
                                  ? Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                          255, 212, 212, 212),
                                      highlightColor: Colors.white,
                                      child: Container(
                                        height: 30,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 248, 184),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const CustomFont(
                                          color:
                                              Color.fromARGB(255, 52, 52, 52),
                                          text: "Additinols Details",
                                          weight: FontWeight.w400,
                                          size: 12),
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              tasks == null
                                  ? Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                          255, 212, 212, 212),
                                      highlightColor: Colors.white,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 10,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 10,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 10,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ))
                                  : CustomFont(
                                      color:
                                          const Color.fromARGB(255, 52, 52, 52),
                                      text: tasks[index]['extradetail'],
                                      weight: FontWeight.w400,
                                      size: 12),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          tasks == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 212, 212, 212),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 30,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 140,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 207, 255, 230),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.work_outline_rounded,
                                        color: GlobalColor.headingcolor,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CustomFont(
                                          color: const Color.fromARGB(
                                              255, 52, 52, 52),
                                          text:
                                              "Task Level: ${tasks[index]['task']['task_level']}",
                                          weight: FontWeight.w400,
                                          size: 12),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tasks == null
                                  ? Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                          255, 212, 212, 212),
                                      highlightColor: Colors.white,
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                GlobalColor.primarycolor),
                                        onPressed: () {
                                          approveWeeklyTaskNow(
                                              userid: tasks[index]['user']
                                                  ['_id'],
                                              task_level: tasks[index]['task']
                                                  ['task_level'],
                                              submitid: tasks[index]['_id']);
                                        },
                                        child: const CustomFont(
                                            color: Colors.white,
                                            text: "Approve Task",
                                            weight: FontWeight.w500,
                                            size: 13),
                                      ),
                                    ),
                              tasks == null
                                  ? Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                          255, 212, 212, 212),
                                      highlightColor: Colors.white,
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: OutlinedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor:
                                              GlobalColor.primarycolor,
                                          elevation: 0,
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        onPressed: () {},
                                        child: CustomFont(
                                            color: GlobalColor.headingcolor,
                                            text: "Decline Task",
                                            weight: FontWeight.w500,
                                            size: 13),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
