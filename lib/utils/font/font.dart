import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFont extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;

  const CustomFont(
      {super.key,
      required this.color,
      required this.text,
      required this.weight,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          GoogleFonts.manrope(fontSize: size, fontWeight: weight, color: color),
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;
  final Color color;
  const HeadingText({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Text(
      text,
      style: GoogleFonts.manrope(
          fontSize: h * 0.025, fontWeight: FontWeight.bold, color: color),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String text;
  final Color color;
  const Subtitle({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Text(
      text,
      style: GoogleFonts.manrope(
          fontSize: h * 0.018, fontWeight: FontWeight.w400, color: color),
    );
  }
}

class DetailText extends StatelessWidget {
  final String text;
  final Color color;
  const DetailText({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Text(
      text,
      style: GoogleFonts.manrope(
          fontSize: h * 0.018, color: color, fontWeight: FontWeight.w300),
    );
  }
}
