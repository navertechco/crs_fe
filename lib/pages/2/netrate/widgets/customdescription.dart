import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDescriptionWidget extends StatelessWidget {
  const CustomDescriptionWidget({
    Key? key,
    this.text = '',
    this.width = 0.5,
    this.fontSize = 0.018,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  final text;
  final width;
  final fontSize;
  final fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      child: Text(text,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: MediaQuery.of(context).size.width * fontSize,
            fontWeight: fontWeight,
          ))),
    );
  }
}
