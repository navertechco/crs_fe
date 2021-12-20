import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/common/constants.dart';

class RoundedFormButton extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final double width;
  final double height;
  final double fontSize;
  final String label;
  final void Function()? onTap;

  const RoundedFormButton({
    Key? key,
    required this.label,
    this.horizontal = 0,
    this.vertical = 0,
    this.width = 0.2,
    this.height = 0.05,
    this.fontSize = 8,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMobile = isMobileDevice() ? 2 : 1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        padding: EdgeInsets.only(
          left: horizontal,
          top: vertical,
        ),
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(50)),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            label,
            strutStyle: StrutStyle(
              fontSize: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height *
                  isMobile *
                  fontSize,
            ),
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height *
                  isMobile *
                  fontSize,
              fontWeight: FontWeight.normal,
            )),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
