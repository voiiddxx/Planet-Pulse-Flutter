// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetailScreen extends StatefulWidget {
  final dynamic eventDetail;
  const EventDetailScreen({super.key, this.eventDetail});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: h * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 95, 95, 95),
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.eventDetail['event_image'],
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
            Container(
              width: double.infinity,
              height: h * 0.6,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 23, 23, 23),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: CustomFont(
                                color: GlobalColor.headingcolor,
                                text: widget.eventDetail['event_date'],
                                weight: FontWeight.w500,
                                size: h * 0.013),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomFont(
                              color: GlobalColor.headingcolor,
                              text: widget.eventDetail['event_title'],
                              weight: FontWeight.w700,
                              size: h * 0.018),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomFont(
                              color: const Color.fromARGB(255, 103, 103, 103),
                              text: widget.eventDetail['event_details'],
                              weight: FontWeight.w500,
                              size: h * 0.016),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: h * 0.07,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 204, 232, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: h * 0.05,
                                  width: w * 0.1,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.location_city_sharp,
                                    color: GlobalColor.primarycolor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                CustomFont(
                                  color: const Color.fromARGB(255, 81, 81, 81),
                                  text:
                                      widget.eventDetail['event_organization'],
                                  weight: FontWeight.w700,
                                  size: h * 0.013,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.yellow[100],
                                    borderRadius: BorderRadius.circular(15)),
                                child: CustomFont(
                                    color: GlobalColor.headingcolor,
                                    text: widget.eventDetail['event_location'],
                                    weight: FontWeight.w500,
                                    size: h * 0.013),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomFont(
                              color: GlobalColor.subtitlecolor,
                              text:
                                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Qui dicta minus molestiae vel beatae natus eveniet ratione temporibus aperiam harum alias officiis assumenda officia quibusdam deleniti eos cupiditate dolore doloribus >Ad dolore dignissimos asperiores dicta facere optio quod commodi nam tempore recusandae. Rerum sed nulla eum vero expedita ex delectus voluptates rem at neque quos facere sequi unde optio aliquam!</p><p>Tenetur quod quidem in voluptatem corporis dolorum dicta sit pariatur porro quaerat autem ipsam odit quam beatae tempora quibusdam illum! Modi velit odio nam nulla unde amet odit pariatur at!</p>",
                              weight: FontWeight.w400,
                              size: h * 0.016),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalColor.primarycolor,
                                    elevation: 0),
                                onPressed: () {},
                                child: CustomFont(
                                    color: Colors.white,
                                    text: "Explore more",
                                    weight: FontWeight.bold,
                                    size: h * 0.016)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
