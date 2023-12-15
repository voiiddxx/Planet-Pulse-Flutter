// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class CommentScreen extends StatefulWidget {
  final String postid;
  const CommentScreen({super.key, required this.postid});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool isLoading = false;
  dynamic allcomments;
  final TextEditingController commentcontroller = TextEditingController();
  void getPostComment() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.get(
        Uri.parse(
            "https://planet-pulse-bphm.onrender.com/get-post-comment?postid=${widget.postid}"),
        headers: <String, String>{
          "Content-type": "application/json",
          "Accept": "application/json",
          'x-auth-token': token!
        },
      );

      setState(() {
        allcomments = jsonDecode(response.body);
      });
    } catch (e) {
      throw e.toString();
    }
  }

  void postcomment(
      {required String commentdetail, required String postid}) async {
    try {
      setState(() {
        isLoading = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      http.Response response = await http.post(
          Uri.parse(
              "https://planet-pulse-bphm.onrender.com/post-comment-user-post"),
          body: jsonEncode({'commentdetail': commentdetail, 'postid': postid}),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        showSnackBar(context, "Comment Added", Colors.white);
        getPostComment();
      } else {
        showSnackBar(context, response.body, Colors.red);
      }

      setState(() {});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getPostComment();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: 800,
      width: 600,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 192, 192, 192),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFont(
            color: GlobalColor.headingcolor,
            text: "Comments",
            weight: FontWeight.w600,
            size: 15,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: const Color.fromARGB(255, 219, 219, 219),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allcomments == null ? 5 : allcomments.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      allcomments == null
                          ? Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 217, 217, 217),
                              highlightColor: Colors.white,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                              ))
                          : InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesNames.otherprofile,
                                    arguments: allcomments[index]['user']
                                        ['username']);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.yellow,
                                    image: DecorationImage(
                                        image: NetworkImage(allcomments[index]
                                                ['user']['userprofile']
                                            .toString()),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          allcomments == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 217, 217, 217),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 10,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                  ))
                              : CustomFont(
                                  color: GlobalColor.headingcolor,
                                  text: allcomments[index]['user']['username'],
                                  weight: FontWeight.w500,
                                  size: 15),
                          const SizedBox(
                            height: 3,
                          ),
                          allcomments == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 217, 217, 217),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 5,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                  ))
                              : SizedBox(
                                  width: w * 0.7,
                                  child: CustomFont(
                                      color: GlobalColor.headingcolor,
                                      text: allcomments[index]['commentdetail'],
                                      weight: FontWeight.w300,
                                      size: 12),
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            color: const Color.fromARGB(255, 189, 189, 189),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            height: 50,
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: commentcontroller,
                    decoration: InputDecoration(
                        hintText: "Write your comment",
                        hintStyle: GoogleFonts.manrope(
                            color: const Color.fromARGB(255, 136, 136, 136),
                            fontSize: 12),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 219, 219, 219),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    postcomment(
                        commentdetail: commentcontroller.text.trim(),
                        postid: widget.postid);
                  },
                  child: Container(
                    height: 60,
                    width: 50,
                    decoration: BoxDecoration(
                      color: GlobalColor.primarycolor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
