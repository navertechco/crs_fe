import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.experience = "coast"})
      : super(key: key);

  final String experience;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> experiences = getContext("experiences");
    return Stack(
      children: [
        Container(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Experience",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: MediaQuery.of(context).size.width * 0.024,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.271,
            height: MediaQuery.of(context).size.height * 0.11,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: Image.asset(
                experiences[experience][2],
                fit: BoxFit.cover,
              ).image,
            ))),
      ],
    );
  }
}
