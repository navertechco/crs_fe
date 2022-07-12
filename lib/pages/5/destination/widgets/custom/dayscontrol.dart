import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../index.dart';

class DaysControlWidget extends StatelessWidget {
  const DaysControlWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          children: [
            Text("Remaining Days: ",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: (dayleft.value) < 1
                      ? Colors.yellow
                      : Color.fromARGB(255, 0, 255, 0),
                  fontSize: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height *
                      15,
                  fontWeight: FontWeight.bold,
                ))),
            Text("    Selected Days: ",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: (accumulated.value) == 0
                      ? Color.fromARGB(255, 0, 255, 0)
                      : Colors.yellow,
                  fontSize: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height *
                      15,
                  fontWeight: FontWeight.bold,
                ))),
          ],
        ));
  }
}
