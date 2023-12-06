// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => RankingScreenState();
}

class RankingScreenState extends State<RankingScreen> {
  dynamic? rankingData;
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
        print(response.body);
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
    // TODO: implement initState
    super.initState();
    getRankingData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/ranking.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFont(
                      color: GlobalColor.headingcolor,
                      text: "Pro Planet Persons",
                      weight: FontWeight.w900,
                      size: 25),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomFont(
                      color: GlobalColor.headingcolor,
                      text: "Ranking of pro planet persons",
                      weight: FontWeight.w300,
                      size: 15),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          //////////////
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(rankingData[1]['userprofile']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomFont(
                              color: GlobalColor.headingcolor,
                              text: rankingData[1]['username'],
                              weight: FontWeight.w500,
                              size: 15),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFont(
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
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(user.userprofile),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomFont(
                              color: GlobalColor.headingcolor,
                              text: rankingData[0]['username'],
                              weight: FontWeight.w500,
                              size: 15),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFont(
                              color: GlobalColor.headingcolor,
                              text: rankingData[0]['pro_planet_rating']
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
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      rankingData[2]['userprofile']),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomFont(
                              color: GlobalColor.headingcolor,
                              text: "${rankingData[2]['username']}",
                              weight: FontWeight.w500,
                              size: 15),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomFont(
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
            height: MediaQuery.of(context).size.height * 0.52,
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
                    itemCount: rankingData.length,
                    itemBuilder: (context, index) {
                      int data = index + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  rankingData[index]
                                                      ['userprofile'])),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                        CustomFont(
                                            color: GlobalColor.headingcolor,
                                            text: rankingData[index]['username']
                                                .toString(),
                                            weight: FontWeight.bold,
                                            size: 18),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const CustomFont(
                                            color: Colors.blue,
                                            text: "500",
                                            weight: FontWeight.w400,
                                            size: 18),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 47, 47, 47),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: CustomFont(
                                            color: Colors.white,
                                            text: data.toString(),
                                            weight: FontWeight.w400,
                                            size: 15),
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
