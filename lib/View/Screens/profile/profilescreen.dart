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
      backgroundColor: const Color.fromARGB(255, 42, 42, 42),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            color: const Color.fromARGB(255, 42, 42, 42),
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
                        color: const Color.fromARGB(255, 85, 85, 85),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 99, 99, 99), width: 1),
                        ),
                        child: Center(
                          child: CustomFont(
                              color: Colors.white,
                              text:
                                  "Pro Planet Rating: ${user.pro_planet_rating}",
                              weight: FontWeight.w400,
                              size: 14),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 99, 99, 99), width: 1),
                        ),
                        child: Center(
                          child: CustomFont(
                              color: Colors.white,
                              text:
                                  "Total Completed Task: ${user.total_completed_task}",
                              weight: FontWeight.w400,
                              size: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 119, 119, 119),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: CustomFont(
                          color: Colors.white,
                          text:
                              "Pro Planet Person Level: ${user.pro_planet_level}",
                          weight: FontWeight.w500,
                          size: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 47, 47, 47),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: 8,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://www.goldenarrow.com/sites/default/files/2022-08/male-gardener-spraying-water-on-plants.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
