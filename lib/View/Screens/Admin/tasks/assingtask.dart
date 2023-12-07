// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetpulse/core/tasks/taskservice.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';

class AssingTask extends StatefulWidget {
  const AssingTask({super.key});

  @override
  State<AssingTask> createState() => _AssingTaskState();
}

class _AssingTaskState extends State<AssingTask> {
  final TextEditingController tasktitle = TextEditingController();
  final TextEditingController taskdetail = TextEditingController();
  final TextEditingController taskguidlines = TextEditingController();
  final TaskService taskService = TaskService();
  File? taskimage;
  selectImage() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result != null) {
        final tempImage = File(result.path);
        setState(() {
          taskimage = tempImage;
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void postData() async {
    try {
      final cloudinary = CloudinaryPublic('dwkmxsthr', 'pdrcp1le');
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(taskimage!.path),
      );
      // ignore: use_build_context_synchronously
      showSnackBar(context, response.secureUrl, Colors.yellow);

      // ignore: use_build_context_synchronously
      await taskService.AssingTask(
          task_title: tasktitle.text.trim(),
          task_detail: taskdetail.text,
          task_guidlines: taskguidlines.text,
          task_image: response.secureUrl,
          task_level: tasklevel);
      // ignore: use_build_context_synchronously
    } catch (e) {
      if (context.mounted) {
        print(e.toString());
        showSnackBar(context, e.toString(), Colors.red);
      }
    }
  }

  String tasklevel = 'Easy';
  Color mediumcolor = Colors.transparent;
  Color mediumtextcolor = Colors.orange;
  Color easycolor = Colors.transparent;
  Color easytextcolor = Colors.green;
  Color hardcolor = Colors.transparent;
  Color hardtextxolor = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: GlobalColor.primarycolor,
          elevation: 0,
          leading: const Icon(
            Icons.all_inclusive_rounded,
            color: Colors.white,
            size: 20,
          ),
          centerTitle: true,
          title: const CustomFont(
              color: Colors.white,
              text: "Assing Task",
              weight: FontWeight.w400,
              size: 15),
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
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFont(
                    color: GlobalColor.headingcolor,
                    text: "Assing Weekly tasks",
                    weight: FontWeight.w500,
                    size: 20),
                const SizedBox(
                  height: 20,
                ),
                const CustomFont(
                    color: Color.fromARGB(255, 64, 64, 64),
                    text: "Set Task Level",
                    weight: FontWeight.w300,
                    size: 15),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          tasklevel = "Easy";
                          easycolor = Colors.green;
                          easytextcolor = Colors.white;
                          mediumcolor = Colors.transparent;
                          mediumtextcolor = Colors.orange;
                          hardcolor = Colors.transparent;
                          hardtextxolor = Colors.red;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                          color: easycolor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.green, width: 1),
                        ),
                        child: Center(
                          child: CustomFont(
                              color: easytextcolor,
                              text: "Easy",
                              weight: FontWeight.w500,
                              size: 15),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tasklevel = "Medium";
                          easycolor = Colors.transparent;
                          easytextcolor = Colors.green;
                          mediumcolor = Colors.orange;
                          mediumtextcolor = Colors.white;
                          hardcolor = Colors.transparent;
                          hardtextxolor = Colors.red;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                          color: mediumcolor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.orange, width: 1),
                        ),
                        child: Center(
                          child: CustomFont(
                              color: mediumtextcolor,
                              text: "Medium",
                              weight: FontWeight.w500,
                              size: 15),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tasklevel = "Hard";
                          easycolor = Colors.transparent;
                          easytextcolor = Colors.green;
                          mediumcolor = Colors.transparent;
                          mediumtextcolor = Colors.orange;
                          hardcolor = Colors.red;
                          hardtextxolor = Colors.white;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                          color: hardcolor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red, width: 1),
                        ),
                        child: Center(
                          child: CustomFont(
                              color: hardtextxolor,
                              text: "Hard",
                              weight: FontWeight.w500,
                              size: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomFont(
                    color: Color.fromARGB(255, 64, 64, 64),
                    text: "Set Task Title*",
                    weight: FontWeight.w400,
                    size: 15),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextField(
                    controller: tasktitle,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "  Give task name",
                        hintStyle: GoogleFonts.manrope(
                            color: const Color.fromARGB(255, 186, 186, 186),
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomFont(
                    color: Color.fromARGB(255, 64, 64, 64),
                    text: "Task Details*",
                    weight: FontWeight.w400,
                    size: 15),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextField(
                    controller: taskdetail,
                    maxLines: 4,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "  Brief the task that what to do",
                        hintStyle: GoogleFonts.manrope(
                            color: const Color.fromARGB(255, 186, 186, 186),
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 0, color: Colors.white),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomFont(
                    color: Color.fromARGB(255, 64, 64, 64),
                    text: "Task Guildlnes*",
                    weight: FontWeight.w400,
                    size: 15),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextField(
                    controller: taskguidlines,
                    maxLines: 4,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "  Give all the task details and rules",
                      hintStyle: GoogleFonts.manrope(
                          color: const Color.fromARGB(255, 186, 186, 186),
                          fontWeight: FontWeight.w800,
                          fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                taskimage != null
                    ? InkWell(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(taskimage!),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                                style: BorderStyle.solid),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: GlobalColor.headingcolor,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CustomFont(
                                    color: GlobalColor.headingcolor,
                                    text: "Select Image",
                                    weight: FontWeight.w500,
                                    size: 15),
                                const SizedBox(
                                  height: 4,
                                ),
                                const CustomFont(
                                    color: Colors.grey,
                                    text:
                                        "Please submit refrence image for proof",
                                    weight: FontWeight.w300,
                                    size: 11),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalColor.headingcolor,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        postData();
                      },
                      child: const CustomFont(
                          color: Colors.white,
                          text: "Assing Task",
                          weight: FontWeight.w700,
                          size: 15)),
                )
              ],
            ),
          ),
        ));
  }
}
