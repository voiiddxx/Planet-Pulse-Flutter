import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? postimage;
  final TextEditingController postcontroller = TextEditingController();
  selectImage() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result != null) {
        final tempImage = File(result.path);
        setState(() {
          postimage = tempImage;
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void addpostnow(
      {required String postcaption, required String postimage}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response response = await http.post(
          Uri.parse("https://planet-pulse-bphm.onrender.com/post"),
          body: jsonEncode({'title': postcaption, 'postimage': postimage}),
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

  void submitPost() async {
    try {
      final cloudinary = CloudinaryPublic('dwkmxsthr', 'pdrcp1le');
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(postimage!.path),
      );
      // ignore: use_build_context_synchronously
      showSnackBar(context, response.secureUrl, Colors.yellow);
      addpostnow(
          postcaption: postcontroller.text.trim(),
          postimage: response.secureUrl);

      // ignore: use_build_context_synchronously
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: "Add Post",
              weight: FontWeight.w400,
              size: 15),
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
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFont(
                  color: GlobalColor.headingcolor,
                  text: "Share your eco friendly activity",
                  weight: FontWeight.w500,
                  size: 15),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: postcontroller,
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    hintText: "Write a caption for your post",
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey)),
              ),
              const SizedBox(
                height: 20,
              ),
              postimage != null
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: FileImage(postimage!), fit: BoxFit.cover)),
                    )
                  : Container(),
              const Expanded(
                child: SizedBox(),
              ),
              InkWell(
                onTap: () {
                  selectImage();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: GlobalColor.primarycolor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                    ),
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
                  ),
                  onPressed: () {
                    submitPost();
                  },
                  child: const CustomFont(
                      color: Colors.white,
                      text: "Share",
                      weight: FontWeight.w600,
                      size: 15),
                ),
              ),
            ],
          ),
        ));
  }
}
