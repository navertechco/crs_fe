import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naver_crs/pages/6/experiences/widgets/experiencedetail/index.dart';
import 'package:naver_crs/pages/6/experiences/widgets/experiencedetail/widgets/index.dart';

import '../../../../index.dart';

class ExperienceRearOptionWidget extends StatelessWidget {
  const ExperienceRearOptionWidget({Key? key, this.experience = "coast"})
      : super(key: key);

  final String experience;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Description",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 204, 164, 61),
            fontSize: MediaQuery.of(context).size.width * 0.015,
            fontWeight: FontWeight.bold,
          )),
        ),
        GestureDetector(
          onTap: () {
            showCustomDialog(context,
                ExperienceDetailWidget(experience: experience), "Close");
          },
          child: Text(
            "click here for details...\n",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: MediaQuery.of(context).size.width * 0.01,
              fontWeight: FontWeight.normal,
            )),
          ),
        ),
      ],
    );
  }
}
