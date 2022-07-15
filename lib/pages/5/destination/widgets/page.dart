import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                Counter(
                  initial: dayleft.value,
                  min: 0,
                  max: 10,
                  bound: 0,
                  step: 1,
                  onValueChanged: (value) {
                    updateDayleft(value);
                  },
                ),
                Text("    Selected Days: $accumulated",
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
            );
          }),
        ),
        CustomRightStarDestinationForm(),
      ],
    );
  }
}
