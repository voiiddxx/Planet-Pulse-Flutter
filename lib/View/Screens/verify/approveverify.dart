import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:http/http.dart' as http;
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApproveVerificationScreen extends StatefulWidget {
  const ApproveVerificationScreen({super.key});

  @override
  State<ApproveVerificationScreen> createState() =>
      _ApproveVerificationScreenState();
}

class _ApproveVerificationScreenState extends State<ApproveVerificationScreen> {
  dynamic getAppliedUser;
  Future<void> getAppliedUserNow() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.get(
          Uri.parse("https://pro-planet-server.onrender.com/get-users-only"),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });
      if (response.statusCode == 200) {
        setState(() {
          getAppliedUser = jsonDecode(response.body);
        });
        print(getAppliedUser[0]['username']);
      } else {
        if (context.mounted) {
          showSnackBar(context, "Some Error", Colors.yellow);
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getAppliedUserNow();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(31, 255, 255, 255),
        elevation: 0,
        leading: const Icon(
          Icons.all_inclusive_rounded,
          color: Colors.black,
          size: 20,
        ),
        centerTitle: true,
        title: const CustomFont(
            color: Colors.black,
            text: "Pro Planet Verification",
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
            child: Icon(
              Icons.logout_sharp,
              color: Colors.black,
              size: 24,
            ),
          ),
          Icon(
            Icons.logout_sharp,
            color: Color.fromARGB(0, 255, 255, 255),
            size: 20,
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(13),
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: getAppliedUser.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            image: DecorationImage(
                                image: index % 2 == 0
                                    ? const AssetImage(
                                        "assets/images/yellowcard.jpg")
                                    : const AssetImage(
                                        "assets/images/blackcard.jpg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomFont(
                                              color: index % 2 != 0
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      255, 33, 33, 33),
                                              text: getAppliedUser[index]
                                                  ['username'],
                                              weight: FontWeight.w900,
                                              size: 38),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomFont(
                                              color: const Color.fromARGB(
                                                  255, 148, 148, 148),
                                              text: getAppliedUser[index]
                                                  ['email'],
                                              weight: FontWeight.w400,
                                              size: 13),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(user.userprofile),
                                            fit: BoxFit.cover),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                            width: 3, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomFont(
                                          color:
                                              Color.fromARGB(255, 71, 71, 71),
                                          text:
                                              "Approve Pro Planet verification Request of ${getAppliedUser[index]['username']}",
                                          weight: FontWeight.w600,
                                          size: 17),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 37, 37, 37),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: CustomFont(
                                                  color: Colors.white,
                                                  text: getAppliedUser[index][
                                                          'total_completed_task']
                                                      .toString(),
                                                  weight: FontWeight.bold,
                                                  size: 13),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const CustomFont(
                                              color: Color.fromARGB(
                                                  255, 71, 71, 71),
                                              text: "Total submited task",
                                              weight: FontWeight.w600,
                                              size: 13),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 37, 37, 37),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: CustomFont(
                                                  color: Colors.white,
                                                  text: getAppliedUser[index]
                                                          ['pro_planet_rating']
                                                      .toString(),
                                                  weight: FontWeight.bold,
                                                  size: 10),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const CustomFont(
                                              color: Color.fromARGB(
                                                  255, 71, 71, 71),
                                              text:
                                                  "Total weekly completed Task",
                                              weight: FontWeight.w600,
                                              size: 13),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 36, 36, 36),
                                                shape:
                                                    ContinuousRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13))),
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  RoutesNames.approvemainscreen,
                                                  arguments:
                                                      getAppliedUser[index]);
                                            },
                                            child: const CustomFont(
                                                color: Colors.white,
                                                text: "Approve Responses",
                                                weight: FontWeight.bold,
                                                size: 13)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
