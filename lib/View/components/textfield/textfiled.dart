import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class customTextFiled extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String hinttext;
  Icon icon;
  bool obscure;

  customTextFiled(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.icon,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
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
                  color: Color.fromARGB(255, 229, 229, 229), width: 1),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
