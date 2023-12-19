// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  dynamic eventdata;

  Future<void> geteventData(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.get(
          Uri.parse("https://planet-pulse-bphm.onrender.com/events"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });

      if (response.statusCode == 200) {
        setState(() {
          eventdata = jsonDecode(response.body);
        });
      } else {
        showSnackBar(context, response.body, Colors.black);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.black);
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    geteventData(context);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
        elevation: 0,
        leading: const Icon(
          Icons.all_inclusive_rounded,
          color: Colors.white,
          size: 20,
        ),
        centerTitle: true,
        title: const CustomFont(
            color: Colors.white,
            text: "Events/Webinars",
            weight: FontWeight.w400,
            size: 13),
        actions: [
          InkWell(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('x-auth-token');
              Navigator.pushReplacementNamed(context, RoutesNames.loginScreen);
            },
            child: const Icon(
              Icons.logout_sharp,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Icon(
            Icons.logout_sharp,
            color: Color.fromARGB(0, 255, 255, 255),
            size: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: h * 0.17,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/events.jpg"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: eventdata == null ? 4 : eventdata.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesNames.eventDetailScreen,
                              arguments: eventdata[index]);
                        },
                        child: Container(
                          height: h * 0.35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                eventdata == null
                                    ? Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(
                                            255, 225, 225, 225),
                                        highlightColor: Colors.white,
                                        child: Container(
                                          height: double.infinity,
                                          width: w * 0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                        ))
                                    : Container(
                                        height: double.infinity,
                                        width: w * 0.3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 22, 22, 22),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    eventdata[index]
                                                        ['event_image']),
                                                fit: BoxFit.cover)),
                                      ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  height: double.infinity,
                                  width: w * 0.55,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      eventdata == null
                                          ? Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  255, 238, 238, 238),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                height: 10,
                                                width: w * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ))
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: Colors.yellow[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                child: CustomFont(
                                                    color: GlobalColor
                                                        .headingcolor,
                                                    text: eventdata[index]
                                                        ['event_date'],
                                                    weight: FontWeight.w500,
                                                    size: h * 0.012),
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      eventdata == null
                                          ? Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  255, 238, 238, 238),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                height: 25,
                                                width: w * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ))
                                          : CustomFont(
                                              color: GlobalColor.headingcolor,
                                              text: eventdata[index]
                                                  ['event_title'],
                                              weight: FontWeight.w900,
                                              size: h * 0.020),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      eventdata == null
                                          ? Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  255, 238, 238, 238),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                height: 35,
                                                width: w * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ))
                                          : CustomFont(
                                              color: GlobalColor.headingcolor,
                                              text:
                                                  "This is the text which is eneterd now just for testing purpose will replace it with the dynamic",
                                              weight: FontWeight.w300,
                                              size: h * 0.012),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      eventdata == null
                                          ? Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  255, 238, 238, 238),
                                              highlightColor: Colors.white,
                                              child: Container(
                                                height: 25,
                                                width: w * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ))
                                          : Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 31, 31, 31),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                  child: const Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                CustomFont(
                                                    color: const Color.fromARGB(
                                                        255, 1, 98, 177),
                                                    text: eventdata[index]
                                                        ['event_location'],
                                                    weight: FontWeight.w600,
                                                    size: h * 0.014)
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
