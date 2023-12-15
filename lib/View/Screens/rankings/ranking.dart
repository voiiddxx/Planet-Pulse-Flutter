// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => RankingScreenState();
}

class RankingScreenState extends State<RankingScreen> {
  dynamic rankingData;
  Future<void> getRankingData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.get(
          Uri.parse("https://planet-pulse-bphm.onrender.com/get-ranking"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      if (response.statusCode == 200) {
        setState(() {
          rankingData = jsonDecode(response.body);
        });
      } else {
        print("We got some error");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getRankingData();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                  image: AssetImage("assets/images/ranking.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h * 0.1,
                  ),
                  CustomFont(
                      color: GlobalColor.headingcolor,
                      text: "Pro Planet Persons",
                      weight: FontWeight.w900,
                      size: 25),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFont(
                      color: GlobalColor.headingcolor,
                      text: "Ranking of pro planet persons",
                      weight: FontWeight.w300,
                      size: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          //////////////

                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesNames.otherprofile,
                                        arguments: rankingData[1]['username']);
                                  },
                                  child: Container(
                                    height: h * 0.09,
                                    width: w * 0.2,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            rankingData[1]['userprofile']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 8,
                          ),
                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 10,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : CustomFont(
                                  color: GlobalColor.headingcolor,
                                  text: rankingData[1]['username'],
                                  weight: FontWeight.w500,
                                  size: h * 0.015),
                          const SizedBox(
                            height: 4,
                          ),
                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 10,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : CustomFont(
                                  color: GlobalColor.headingcolor,
                                  text: rankingData[1]['pro_planet_rating']
                                      .toString(),
                                  weight: FontWeight.w500,
                                  size: 12),

                          //////////////
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          //////////////

                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: h * 0.2,
                                    width: w * 0.3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ))
                              : InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesNames.otherprofile,
                                        arguments: rankingData[0]['username']);
                                  },
                                  child: Container(
                                    height: h * 0.2,
                                    width: w * 0.3,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            rankingData[0]['userprofile']),
                                      ),
                                    ),
                                  ),
                                ),

                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 10,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : CustomFont(
                                  color: GlobalColor.headingcolor,
                                  text: rankingData[0]['username'],
                                  weight: FontWeight.w500,
                                  size: 15),
                          const SizedBox(
                            height: 4,
                          ),
                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 10,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : CustomFont(
                                  color: GlobalColor.headingcolor,
                                  text: rankingData[0]['pro_planet_rating']
                                      .toString(),
                                  weight: FontWeight.w500,
                                  size: 12),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesNames.otherprofile,
                                        arguments: rankingData[2]['username']);
                                  },
                                  child: Container(
                                    height: h * 0.09,
                                    width: w * 0.2,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            rankingData[2]['userprofile'],
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 10,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : CustomFont(
                                  color: GlobalColor.headingcolor,
                                  text: "${rankingData[2]['username']}",
                                  weight: FontWeight.w500,
                                  size: 15),
                          const SizedBox(
                            height: 4,
                          ),
                          rankingData == null
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(128, 208, 208, 208),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: 10,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ))
                              : CustomFont(
                                  color: GlobalColor.headingcolor,
                                  text: rankingData[2]['pro_planet_rating']
                                      .toString(),
                                  weight: FontWeight.w500,
                                  size: 12),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          ///====================ALL container for showing the rankings==========//
          Container(
            height: MediaQuery.of(context).size.height * 0.46,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: rankingData == null ? 4 : rankingData.length,
                    itemBuilder: (context, index) {
                      int data = index + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            Container(
                              height: h * 0.09,
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    rankingData == null
                                        ? Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                128, 208, 208, 208),
                                            highlightColor: Colors.white,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RoutesNames.otherprofile,
                                                  arguments: rankingData[index]
                                                      ['username']);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          rankingData[index]
                                                              ['userprofile'])),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        rankingData == null
                                            ? Shimmer.fromColors(
                                                baseColor: const Color.fromARGB(
                                                    128, 208, 208, 208),
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  height: 10,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ))
                                            : CustomFont(
                                                color: GlobalColor.headingcolor,
                                                text: rankingData[index]
                                                        ['username']
                                                    .toString(),
                                                weight: FontWeight.bold,
                                                size: h * 0.016),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        rankingData == null
                                            ? Shimmer.fromColors(
                                                baseColor: const Color.fromARGB(
                                                    128, 208, 208, 208),
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  height: 10,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ))
                                            : CustomFont(
                                                color: Color.fromARGB(
                                                    255, 43, 43, 43),
                                                text:
                                                    "Ratings: ${rankingData[index]['pro_planet_rating']}",
                                                weight: FontWeight.w500,
                                                size: h * 0.014),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 0.2,
                                          width: w * 0.6,
                                          color: const Color.fromARGB(
                                              255, 80, 80, 80),
                                        )
                                      ],
                                    ),
                                    rankingData == null
                                        ? Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                128, 208, 208, 208),
                                            highlightColor: Colors.white,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                            ))
                                        : Container(
                                            height: h * 0.03,
                                            width: w * 0.07,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 47, 47, 47),
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: CustomFont(
                                                  color: Colors.white,
                                                  text: data.toString(),
                                                  weight: FontWeight.w400,
                                                  size: h * 0.012),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
