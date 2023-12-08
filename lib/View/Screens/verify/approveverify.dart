import 'package:flutter/material.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:http/http.dart' as http;
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
      print(response.body);
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
      backgroundColor: Color.fromARGB(255, 42, 42, 42),
      appBar: AppBar(
        backgroundColor: GlobalColor.primarycolor,
        elevation: 0,
        leading: const Icon(
          Icons.all_inclusive_rounded,
          color: Colors.white,
          size: 20,
        ),
        centerTitle: true,
        title: const CustomFont(
            color: Colors.white,
            text: "Assing Task",
            weight: FontWeight.w400,
            size: 13),
        actions: const [
          Icon(
            Icons.logout_sharp,
            color: Colors.white,
            size: 24,
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
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  image: const DecorationImage(
                      image: AssetImage("assets/images/yellowcard.jpg"),
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
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomFont(
                                    color:
                                        const Color.fromARGB(255, 33, 33, 33),
                                    text: "${user.username} Kumar",
                                    weight: FontWeight.w900,
                                    size: 38),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomFont(
                                    color: const Color.fromARGB(
                                        255, 148, 148, 148),
                                    text: "${user.email} ",
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
                                  image: NetworkImage(user.userprofile),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(width: 3, color: Colors.white),
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
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomFont(
                                color: Color.fromARGB(255, 71, 71, 71),
                                text:
                                    "Approve Pro Planet verification Request of Deepan Vohra",
                                weight: FontWeight.w600,
                                size: 17),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 37, 37, 37),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                    child: CustomFont(
                                        color: Colors.white,
                                        text: "5",
                                        weight: FontWeight.bold,
                                        size: 13),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const CustomFont(
                                    color: Color.fromARGB(255, 71, 71, 71),
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
                                      color:
                                          const Color.fromARGB(255, 37, 37, 37),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                    child: CustomFont(
                                        color: Colors.white,
                                        text: "1200",
                                        weight: FontWeight.bold,
                                        size: 10),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const CustomFont(
                                    color: Color.fromARGB(255, 71, 71, 71),
                                    text: "Total weekly completed Task",
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
                                          const Color.fromARGB(255, 36, 36, 36),
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13))),
                                  onPressed: () {},
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
