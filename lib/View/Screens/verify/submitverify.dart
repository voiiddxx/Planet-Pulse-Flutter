import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planetpulse/View/components/textfield/whitetextfiled.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';

class SubmitSCreen extends StatefulWidget {
  final File image;
  final String submitTask;
  const SubmitSCreen(
      {super.key, required this.image, required this.submitTask});

  @override
  State<SubmitSCreen> createState() => _SubmitSCreenState();
}

class _SubmitSCreenState extends State<SubmitSCreen> {
  final TextEditingController detailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                text: "Submit Your Task",
                weight: FontWeight.w400,
                size: 20),
            const SizedBox(
              height: 20,
            ),
            CustomFont(
                color: GlobalColor.headingcolor,
                text: "You are applying verification for ${widget.submitTask}",
                weight: FontWeight.w400,
                size: 15),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: FileImage(widget.image), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            WhiteTextFiled(
              hinttext: "Give Some Detail About Proof",
              icon: const Icon(
                Icons.web_stories_rounded,
                color: Colors.black,
              ),
              controller: detailcontroller,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                        elevation: 0,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const CustomFont(
                        color: Colors.white,
                        text: "Submit",
                        weight: FontWeight.w500,
                        size: 15)))
          ],
        ),
      ),
    );
  }
}
