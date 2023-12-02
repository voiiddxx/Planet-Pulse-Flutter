import 'package:flutter/material.dart';
import 'package:planetpulse/utils/font/font.dart';

void showSnackBar(BuildContext context, String text, Color responseColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Padding(
    padding: const EdgeInsets.all(20),
    child: Subtitle(color: Colors.white, text: text),
  )));
}
