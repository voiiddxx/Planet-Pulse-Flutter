import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Let's Contribute To Planet By",
                    style: GoogleFonts.leagueGothic(
                        fontSize: h * 0.05, color: GlobalColor.headingcolor),
                  ),
                  Text(
                    "Pro Planet Person ",
                    style: GoogleFonts.leagueGothic(
                        fontSize: h * 0.05, color: GlobalColor.subtitlecolor),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  DetailText(
                      color: GlobalColor.headingcolor,
                      text:
                          "Let’s take a small step to give our contribution to the planet so that our upcoming genereation will stay alive and lorem espum whih can save us"),
                  Image.asset(
                    "assets/images/planet.png",
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => {provider.getCurrUser(context)},
                          child: Center(
                            child: Container(
                              height: h * 0.1,
                              width: w * 0.2,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.send_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ))
                    ],
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
