import 'package:flutter/material.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
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
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(255, 173, 173, 173),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
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
                                      image: NetworkImage(user.userprofile)),
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
                                      text: user.username,
                                      weight: FontWeight.bold,
                                      size: 30),
                                  const SizedBox(height: 5),
                                  CustomFont(
                                      color: Colors.white,
                                      text: user.email,
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
                                              "🏆  Pro planet level : ${user.pro_planet_level}",
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
                            text: user.pro_planet_rating.toString(),
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
                            text: user.total_completed_task.toString(),
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
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFont(
                    color: GlobalColor.headingcolor,
                    text: "Additiniol options",
                    weight: FontWeight.w600,
                    size: 15),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: GlobalColor.primarycolor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Icon(
                          Icons.auto_awesome_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomFont(
                        color: GlobalColor.subtitlecolor,
                        text: "Become an admin",
                        weight: FontWeight.w400,
                        size: 16),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: GlobalColor.headingcolor,
                      size: 30,
                    )
                  ],
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 72, 58),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Icon(
                          Icons.ads_click_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomFont(
                        color: GlobalColor.subtitlecolor,
                        text: "Become an admin",
                        weight: FontWeight.w400,
                        size: 16),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: GlobalColor.headingcolor,
                      size: 30,
                    )
                  ],
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 51, 173, 55),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Icon(
                          Icons.whatshot_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomFont(
                        color: GlobalColor.subtitlecolor,
                        text: "Become an admin",
                        weight: FontWeight.w400,
                        size: 16),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: GlobalColor.headingcolor,
                      size: 30,
                    )
                  ],
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 32, 32, 32),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Icon(
                          Icons.login_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomFont(
                        color: GlobalColor.subtitlecolor,
                        text: "Log Out",
                        weight: FontWeight.w400,
                        size: 16),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: GlobalColor.headingcolor,
                      size: 30,
                    )
                  ],
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
