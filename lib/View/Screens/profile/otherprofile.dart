// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OtherProfileScreen extends StatefulWidget {
  final String otherprofile;
  const OtherProfileScreen({
    super.key,
    required this.otherprofile,
  });

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  dynamic otherUserdata;

  dynamic getOtheruserdatanow() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.get(
          Uri.parse(
              "https://planet-pulse-bphm.onrender.com/get-specific-user?username=${widget.otherprofile}"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      if (response.statusCode == 200) {
        setState(() {
          otherUserdata = jsonDecode(response.body);
        });
      } else {
        showSnackBar(context, response.body, Colors.blue);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.black);
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getOtheruserdatanow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 42, 42, 42),
                image: DecorationImage(
                    image: AssetImage("assets/images/profile.jpg"),
                    fit: BoxFit.cover),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(101, 85, 85, 85),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          otherUserdata['userprofile']),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFont(
                                      color: Colors.white,
                                      text: otherUserdata['username'],
                                      weight: FontWeight.bold,
                                      size: 30),
                                  const SizedBox(height: 5),
                                  CustomFont(
                                      color: Colors.white,
                                      text: otherUserdata['email'],
                                      weight: FontWeight.w300,
                                      size: 15),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 32,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            125, 69, 69, 69),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: CustomFont(
                                          color: const Color.fromARGB(
                                              255, 44, 255, 244),
                                          text:
                                              "🏆  Pro planet level : ${otherUserdata['pro_planet_level']}",
                                          weight: FontWeight.w600,
                                          size: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomFont(
                            color: Colors.white,
                            text: otherUserdata['pro_planet_rating'].toString(),
                            weight: FontWeight.w800,
                            size: 20),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: const CustomFont(
                              color: Colors.white,
                              text: "Pro Planet Ratings 🍀",
                              weight: FontWeight.w400,
                              size: 15),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 100,
                          width: 0.5,
                          color: const Color.fromARGB(255, 198, 198, 198),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CustomFont(
                            color: Colors.white,
                            text: otherUserdata['total_completed_task']
                                .toString(),
                            weight: FontWeight.w800,
                            size: 20),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: const CustomFont(
                              color: Colors.white,
                              text: "Completed Tasks ✔️",
                              weight: FontWeight.w400,
                              size: 15),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                    "https://cdn.dribbble.com/users/2460221/screenshots/14347554/no-post.png"),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 201, 201, 201),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
