import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignEvents extends StatefulWidget {
  const AssignEvents({super.key});

  @override
  State<AssignEvents> createState() => _AssignEventsState();
}

class _AssignEventsState extends State<AssignEvents> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
              text: "Create Event",
              weight: FontWeight.w400,
              size: 13),
          actions: [
            InkWell(
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('x-auth-token');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(
                    context, RoutesNames.loginScreen);
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFont(
                  color: GlobalColor.headingcolor,
                  text: "Create Event",
                  weight: FontWeight.w700,
                  size: h * 0.018),
              SizedBox(
                height: h * 0.005,
              ),
              CustomFont(
                  color: GlobalColor.headingcolor,
                  text:
                      "Create event or post event so that more people will know about event and it become so grand",
                  weight: FontWeight.w400,
                  size: h * 0.014),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    hintText: "Title of event",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey)),
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: "Event Details",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: "5 August 2014",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: "Paste Event Link",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 50,
                width: w * 0.4,
                decoration: BoxDecoration(
                  color: GlobalColor.primarycolor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    CustomFont(
                        color: Colors.white,
                        text: "Upload Poster",
                        weight: FontWeight.w500,
                        size: h * 0.013),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
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
                        text: "Create Event",
                        weight: FontWeight.w700,
                        size: h * 0.015),
                  )),
            ],
          ),
        ));
  }
}
