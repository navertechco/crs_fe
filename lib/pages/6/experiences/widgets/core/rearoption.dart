import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../index.dart';

class RearOptionWidget extends StatelessWidget {
  const RearOptionWidget({Key? key, this.experience = "coast"})
      : super(key: key);

  final String experience;
  @override
  Widget build(BuildContext context) {
    
    var row = experiences
        .toList()
        .firstWhere((element) => element["title"] == experience);
    return Column(
      children: [
        Text(
          " Title",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 204, 164, 61),
            fontSize: MediaQuery.of(context).size.width * 0.015,
            fontWeight: FontWeight.bold,
          )),
        ),
        Text(
          "descripcion\n",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: MediaQuery.of(context).size.width * 0.01,
            fontWeight: FontWeight.normal,
          )),
        ),
      ],
    );
  }
}
