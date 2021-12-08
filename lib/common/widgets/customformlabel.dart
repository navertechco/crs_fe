import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormLabelWidget extends StatelessWidget {
  const CustomFormLabelWidget({
    Key? key,
    required this.label,
    required this.fontWeight,
  }) : super(key: key);
  final String label;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        color: const Color.fromRGBO(0, 0, 1, 0.5),
        fontSize: MediaQuery.of(context).size.width * 0.015,
        fontWeight: fontWeight,
      )),
    );
  }
}
