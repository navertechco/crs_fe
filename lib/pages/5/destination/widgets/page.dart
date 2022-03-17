import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../index.dart';
import '../index.dart';
import 'index.dart';

class DestinationWidget extends GetView<DestinationController> {
  const DestinationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomLeftStarDestinationForm(),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: MediaQuery.of(context).size.width * 0.1,
          child: Obx(() {
            return Row(
              children: [
                Text("Remaining Days: $dayleft",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: (dayleft.value) < 1
                          ? Color.fromARGB(255, 255, 0, 0)
                          : Color.fromARGB(255, 0, 0, 0),
                      fontSize: MediaQuery.of(context).size.width /
                          MediaQuery.of(context).size.height *
                          10,
                      fontWeight: FontWeight.bold,
                    ))),
                Text("    Selected Days: $accumulated",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: (accumulated.value) == 0
                          ? Color.fromARGB(255, 255, 0, 0)
                          : Color.fromARGB(255, 0, 255, 0),
                      fontSize: MediaQuery.of(context).size.width /
                          MediaQuery.of(context).size.height *
                          10,
                      fontWeight: FontWeight.bold,
                    ))),
              ],
            );
          }),
        ),
        CustomRightStarDestinationForm(),
      ],
    );
  }
}
