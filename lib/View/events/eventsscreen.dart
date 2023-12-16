// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    // TODO: implement initState
    super.initState();
    geteventData(context);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 234),
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
              // ignore: use_build_context_synchronously
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
          padding: const EdgeInsets.all(5),
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
                  itemCount: eventdata.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: h * 0.16,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: w * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.yellow,
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://s4x2k6c7.rocketcdn.me/wglz/files/2015/04/Earth-Day-Flyer-page-001.jpg"),
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
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.yellow[100],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          child: CustomFont(
                                              color: GlobalColor.headingcolor,
                                              text: "5 December 2021",
                                              weight: FontWeight.w500,
                                              size: h * 0.012),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomFont(
                                          color: const Color.fromARGB(
                                              255, 99, 99, 99),
                                          text:
                                              "Green Enviroment Mission India 2023",
                                          weight: FontWeight.w900,
                                          size: h * 0.020),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                color: Colors.blue[100],
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomFont(
                                              color: const Color.fromARGB(
                                                  255, 1, 103, 186),
                                              text:
                                                  "Save The Planet Organization",
                                              weight: FontWeight.w600,
                                              size: h * 0.014)
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
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
              )
            ],
          )),
    );
  }
}
