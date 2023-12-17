// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/components/textfield/textfiled.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final scaffoldState = GlobalKey<ScaffoldState>();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController addresscontroller = TextEditingController();
  File? profileimage;

  bool isLoadiing = false;
  selectImage() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result != null) {
        final tempImage = File(result.path);
        setState(() {
          profileimage = tempImage;
        });
        setState(() {});
      }
    } catch (e) {
      throw e.toString();
    }
  }

  updateImageofuser() async {
    try {
      showSnackBar(context, "Updating image", Colors.red);
      Navigator.pop(context);
      final cloudinary = CloudinaryPublic('dwkmxsthr', 'pdrcp1le');
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(profileimage!.path),
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response postresponse = await http.patch(
          Uri.parse("https://planet-pulse-bphm.onrender.com/update-profile"),
          body: jsonEncode(
            {
              'userprofile': response.secureUrl,
            },
          ),
          headers: <String, String>{
            "Content-type": "application/json",
            "Accept": "application/json",
            'x-auth-token': token!
          });

      if (postresponse.statusCode == 200) {
        showSnackBar(context, "Image Updated", Colors.red);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      key: scaffoldState,
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
                          InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                  height: h * 0.4,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        height: 10,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 208, 208, 208),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      profileimage != null
                                          ? Container(
                                              height: 150,
                                              width: w * 0.3,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          profileimage!),
                                                      fit: BoxFit.cover),
                                                  color: const Color.fromARGB(
                                                      255, 215, 215, 215),
                                                  shape: BoxShape.circle),
                                            )
                                          : Container(
                                              height: 150,
                                              width: w * 0.3,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          user.userprofile),
                                                      fit: BoxFit.cover),
                                                  color: const Color.fromARGB(
                                                      255, 215, 215, 215),
                                                  shape: BoxShape.circle),
                                            ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 50,
                                        width: w * 0.8,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 213, 213, 213),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                selectImage();
                                              },
                                              child: const CustomFont(
                                                  color: Colors.black,
                                                  text: "Upload photo",
                                                  weight: FontWeight.w400,
                                                  size: 11),
                                            ),
                                            const CustomFont(
                                                color: Colors.black,
                                                text: "|",
                                                weight: FontWeight.w400,
                                                size: 11),
                                            const CustomFont(
                                                color: Colors.black,
                                                text: "Select from gallery",
                                                weight: FontWeight.w400,
                                                size: 11),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: w * 0.8,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  GlobalColor.primarycolor),
                                          onPressed: () {
                                            updateImageofuser();
                                          },
                                          child: const CustomFont(
                                              color: Colors.white,
                                              text: "Update",
                                              weight: FontWeight.w600,
                                              size: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
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
            padding: const EdgeInsets.all(20),
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
                InkWell(
                  onTap: () {
                    scaffoldState.currentState!.showBottomSheet(
                      (context) => Container(
                        height: 800,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 8,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomFont(
                                color: GlobalColor.headingcolor,
                                text: "Apply for admin",
                                weight: FontWeight.w700,
                                size: h * 0.018),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFont(
                                color: GlobalColor.headingcolor,
                                text: "Please fill the correct imformantion",
                                weight: FontWeight.w500,
                                size: h * 0.016),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(user.userprofile)),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomFont(
                                        color: GlobalColor.headingcolor,
                                        text: user.username,
                                        weight: FontWeight.w400,
                                        size: h * .016),
                                    CustomFont(
                                        color: GlobalColor.headingcolor,
                                        text: user.email,
                                        weight: FontWeight.w400,
                                        size: h * .016),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFont(
                                      color: GlobalColor.headingcolor,
                                      text: "Permanent address",
                                      weight: FontWeight.w400,
                                      size: h * 0.014),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  customTextFiled(
                                      controller: addresscontroller,
                                      hinttext: "Permanent address",
                                      icon: Icon(Icons.location_on),
                                      obscure: false)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutesNames.verificationscreen);
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 72, 58),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Icon(
                            Icons.verified,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomFont(
                          color: GlobalColor.subtitlecolor,
                          text: "Pro Planet Verification",
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
                          color: const Color.fromARGB(255, 51, 173, 55),
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
                InkWell(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('x-auth-token');
                    Navigator.pushNamed(context, RoutesNames.loginScreen);
                  },
                  child: Row(
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
