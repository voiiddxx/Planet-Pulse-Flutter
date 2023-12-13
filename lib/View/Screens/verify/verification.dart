import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetpulse/View/Screens/verify/submitverify.dart';
import 'package:planetpulse/core/verify/verifyservice.dart';
import 'package:planetpulse/global/global.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final VerificationService verificationService = VerificationService();
  File? submitimage;
  String? submitTask;

  clickImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result != null) {
      if (context.mounted) {
        final tempImage = File(result.path);
        setState(() {
          this.submitimage = tempImage;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SubmitSCreen(image: submitimage!, submitTask: submitTask!),
          ),
        );
      }
    } else {
      if (context.mounted) {
        showSnackBar(context, "Please Click Image", Colors.yellow);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFont(
                  color: GlobalColor.headingcolor,
                  text: "Pro Planet Verification",
                  weight: FontWeight.w700,
                  size: h * 0.025),
              const SizedBox(
                height: 10,
              ),
              CustomFont(
                  color: GlobalColor.subtitlecolor,
                  text:
                      "To apply for pro planet verification upload the proof of given below tasks and on uploading the fake proofs your points will be deducted",
                  weight: FontWeight.w400,
                  size: h * 0.018),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: GloablVariable.verifyconfig.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(GloablVariable
                                            .verifyconfig[index]['image']!),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              CustomFont(
                                  color: Colors.black,
                                  text: GloablVariable.verifyconfig[index]
                                      ['title']!,
                                  weight: FontWeight.w500,
                                  size: h * 0.022),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomFont(
                                  color: Colors.black,
                                  text: GloablVariable.verifyconfig[index]
                                      ['subtitle']!,
                                  weight: FontWeight.w300,
                                  size: 12),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {
                                    setState(() {
                                      submitTask = GloablVariable
                                          .verifyconfig[index]['title'];
                                    });
                                    clickImage();
                                  },
                                  child: CustomFont(
                                    color: GlobalColor.headingcolor,
                                    weight: FontWeight.w400,
                                    size: 15,
                                    text: "Submit proof",
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
