// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planetpulse/core/verify/verifyservice.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

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
  final VerificationService verificationService = VerificationService();
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
      }
    } catch (e) {
      throw e.toString();
    }
  }

  approveVerificationtasks(dynamic id, dynamic postid) async {
    dynamic data = await verificationService.approveResponse(
        id: id, postid: postid, context: context);
    if (data == 200) {
      showSnackBar(context, "Approved", Colors.red);
    }
    getuserQuestion();
    setState(() {});
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
                  questions == null
                      ? Shimmer.fromColors(
                          baseColor: const Color.fromARGB(215, 34, 34, 34),
                          highlightColor: Colors.black,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black,
                            ),
                          ))
                      : Container(
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
                  questions == null
                      ? Shimmer.fromColors(
                          baseColor: const Color.fromARGB(215, 34, 34, 34),
                          highlightColor: Colors.black,
                          child: Container(
                            height: 20,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                            ),
                          ),
                        )
                      : CustomFont(
                          color: Colors.white,
                          text: questions['username'],
                          weight: FontWeight.w600,
                          size: 25),
                  const SizedBox(
                    height: 10,
                  ),
                  questions == null
                      ? Shimmer.fromColors(
                          baseColor: const Color.fromARGB(215, 34, 34, 34),
                          highlightColor: Colors.black,
                          child: Container(
                            height: 15,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                            ),
                          ))
                      : CustomFont(
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
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                      child: CustomFont(
                          color: GlobalColor.headingcolor,
                          text: "Submitted Assignments",
                          weight: FontWeight.w600,
                          size: 14),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            questions == null ? 2 : questions['ques'].length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            height: 500,
                            width: 500,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 27, 27, 27),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  questions == null
                                      ? Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                              215, 34, 34, 34),
                                          highlightColor: Colors.black,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Colors.black,
                                            ),
                                          ))
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      questions['ques'][index]
                                                          ['quesImage']),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            143, 62, 62, 62),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.animation_sharp,
                                                color: questions == null
                                                    ? Colors.transparent
                                                    : Colors.yellow,
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              questions == null
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          const Color.fromARGB(
                                                              215, 34, 34, 34),
                                                      highlightColor:
                                                          Colors.black,
                                                      child: Container(
                                                        height: 20,
                                                        width: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.black,
                                                        ),
                                                      ))
                                                  : CustomFont(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      text: questions['ques']
                                                          [index]['question'],
                                                      weight: FontWeight.w600,
                                                      size: 15),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: questions == null
                                                    ? Colors.transparent
                                                    : Color.fromARGB(
                                                        255, 59, 216, 255),
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              questions == null
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          const Color.fromARGB(
                                                              215, 34, 34, 34),
                                                      highlightColor:
                                                          Colors.black,
                                                      child: Container(
                                                        height: 20,
                                                        width: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.black,
                                                        ),
                                                      ))
                                                  : const SizedBox(
                                                      width: 250,
                                                      child: CustomFont(
                                                          color:
                                                              Color
                                                                  .fromARGB(
                                                                      255,
                                                                      219,
                                                                      219,
                                                                      219),
                                                          text:
                                                              "Baba Farid college of engineering and technology",
                                                          weight:
                                                              FontWeight.w300,
                                                          size: 13),
                                                    ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              questions == null
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          const Color.fromARGB(
                                                              215, 34, 34, 34),
                                                      highlightColor:
                                                          Colors.black,
                                                      child: Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.37,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.black,
                                                        ),
                                                      ))
                                                  : SizedBox(
                                                      height: 50,
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.37,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              shape: ContinuousRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10))),
                                                          onPressed: () {
                                                            approveVerificationtasks(
                                                                questions[
                                                                    '_id'],
                                                                questions['ques']
                                                                        [index]
                                                                    ['_id']);
                                                          },
                                                          child: CustomFont(
                                                              color: GlobalColor
                                                                  .headingcolor,
                                                              text: "Approve",
                                                              weight:
                                                                  FontWeight.w400,
                                                              size: 13))),
                                              questions == null
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          const Color.fromARGB(
                                                              215, 34, 34, 34),
                                                      highlightColor:
                                                          Colors.black,
                                                      child: Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.37,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.black,
                                                        ),
                                                      ))
                                                  : SizedBox(
                                                      height: 50,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.37,
                                                      child: OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          shape:
                                                              ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                        child: const CustomFont(
                                                            color: Colors.white,
                                                            text: "Decline",
                                                            weight:
                                                                FontWeight.w400,
                                                            size: 13),
                                                      ),
                                                    ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
