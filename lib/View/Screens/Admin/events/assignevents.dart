// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/core/events/eventservice.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignEvents extends StatefulWidget {
  const AssignEvents({super.key});

  @override
  State<AssignEvents> createState() => _AssignEventsState();
}

class _AssignEventsState extends State<AssignEvents> {
  final TextEditingController eventnamecontroller = TextEditingController();
  final TextEditingController eventdetailcontroller = TextEditingController();
  final TextEditingController eventorganizationcontroller =
      TextEditingController();
  final TextEditingController eventdatecontroller = TextEditingController();
  final TextEditingController eventlinkcontroller = TextEditingController();
  final TextEditingController eventlocationcontroller = TextEditingController();
  final EventService eventService = EventService();

  File? eventimage;

  bool isLoadiing = false;
  selectImage() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result != null) {
        final tempImage = File(result.path);
        setState(() {
          eventimage = tempImage;
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  uploadevent() async {
    try {
      setState(() {
        isLoadiing = true;
      });
      final cloudinary = CloudinaryPublic('dwkmxsthr', 'pdrcp1le');
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(eventimage!.path),
      );

      dynamic data = await eventService.postEvent(
        context: context,
        event_title: eventnamecontroller.text.trim(),
        event_details: eventdetailcontroller.text.trim(),
        event_organization: eventorganizationcontroller.text.trim(),
        event_date: eventdatecontroller.text.trim(),
        event_link: eventlinkcontroller.text.trim(),
        event_image: response.secureUrl,
        event_location: eventlocationcontroller.text.trim(),
      );
      setState(() {
        isLoadiing = false;
      });

      if (data == 200) {
        showSnackBar(context, "Created", Colors.yellow);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    eventnamecontroller.dispose();
    eventdetailcontroller.dispose();
    eventdatecontroller.dispose();
    eventlocationcontroller.dispose();
    eventlinkcontroller.dispose();
  }

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
        body: SizedBox(
          height: h * 1,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Container(
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
                      controller: eventnamecontroller,
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
                      controller: eventdetailcontroller,
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
                      controller: eventorganizationcontroller,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        hintText: "Oraganization name",
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
                      controller: eventdatecontroller,
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
                      controller: eventlinkcontroller,
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
                    TextField(
                      controller: eventlocationcontroller,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        hintText: "Online/Bathinda,India",
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                    ),
                    eventimage != null
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(eventimage!),
                                    fit: BoxFit.cover)),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: h * 0.15,
                    ),
                    InkWell(
                      onTap: () {
                        selectImage();
                      },
                      child: Container(
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
                                text: "Upload banner",
                                weight: FontWeight.w500,
                                size: h * 0.013),
                          ],
                        ),
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
                          onPressed: () {
                            uploadevent();
                          },
                          child: isLoadiing == true
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : CustomFont(
                                  color: Colors.white,
                                  text: "Create Event",
                                  weight: FontWeight.w700,
                                  size: h * 0.015),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
