import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitleApp extends StatelessWidget {
  const TextTitleApp({
    super.key,
    this.color = Colors.black,
    this.size = 14.0,
    required this.text,
  });

  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.raleway(
          fontWeight: FontWeight.bold, color: color, fontSize: size),
    );
  }
}

class TextNormalApp extends StatelessWidget {
  const TextNormalApp({
    super.key,
    this.color = Colors.black,
    this.size = 14.0,
    required this.text,
  });

  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.raleway(
            fontWeight: FontWeight.normal, color: color, fontSize: size));
  }
}
