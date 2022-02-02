import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, required this.experience})
      : super(key: key);
  final String experience;
  @override
  Widget build(BuildContext context) {
    // getExperiences("", experience, null, null, 1);
    var experiences = getContext("experiences");
    var row = experiences
        .toList()
        .firstWhere((element) => element["title"] == experience);
    return Stack(
      children: [
        Container(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                experience,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: MediaQuery.of(context).size.width * 0.018,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.271,
            height: MediaQuery.of(context).size.height * 0.11,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(
                row["image"],
                fit: BoxFit.cover,
              ).image,
            ))),
      ],
    );
  }
}
