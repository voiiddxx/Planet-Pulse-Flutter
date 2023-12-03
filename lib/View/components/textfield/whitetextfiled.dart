// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteTextFiled extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String hinttext;
  Icon icon;
  WhiteTextFiled(
      {super.key,
      required this.hinttext,
      required this.icon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 232, 232, 232),
          prefixIcon: icon,
          hintStyle: GoogleFonts.manrope(
            fontSize: 14,
          ),
          hintText: hinttext,
          enabled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 232, 232, 232), width: 1),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
