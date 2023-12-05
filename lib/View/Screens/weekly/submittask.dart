// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:planetpulse/View/components/textfield/textfiled.dart';
import 'package:planetpulse/core/tasks/taskservice.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';

class SubmitTaskScreen extends StatefulWidget {
  final dynamic task;
  final File imagetosubmit;
  const SubmitTaskScreen({super.key, this.task, required this.imagetosubmit});

  @override
  State<SubmitTaskScreen> createState() => _SubmitTaskScreenState();
}

class _SubmitTaskScreenState extends State<SubmitTaskScreen> {
  final TextEditingController taskdetailcontroller = TextEditingController();

  final TaskService taskService = TaskService();

  void postData() async {
    try {
      final cloudinary = CloudinaryPublic('dwkmxsthr', 'pdrcp1le');
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(widget.imagetosubmit.path),
      );
      // ignore: use_build_context_synchronously
      showSnackBar(context, response.secureUrl, Colors.yellow);

      // ignore: use_build_context_synchronously
      taskService.submitTask(
          task: widget.task,
          image: response.secureUrl,
          extradetail: taskdetailcontroller.text.trim(),
          context: context);
      // ignore: use_build_context_synchronously
    } catch (e) {
      if (context.mounted) {
        print(e.toString());
        showSnackBar(context, e.toString(), Colors.red);
      }
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFont(
                color: GlobalColor.headingcolor,
                text: "Task Submiision",
                weight: FontWeight.w600,
                size: 20),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(widget.imagetosubmit),
                              fit: BoxFit.cover),
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    customTextFiled(
                        controller: taskdetailcontroller,
                        hinttext: "Additinols Task Details",
                        icon: const Icon(Icons.double_arrow_outlined),
                        obscure: false),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          postData();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 33, 33, 33),
                            elevation: 0,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const CustomFont(
                            color: Colors.white,
                            text: "Submit",
                            weight: FontWeight.w500,
                            size: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
