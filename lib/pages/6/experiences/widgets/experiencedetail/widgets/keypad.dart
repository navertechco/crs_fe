import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class KeypadWidget extends StatelessWidget {
  const KeypadWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final experience;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.3,
          top: MediaQuery.of(context).size.height * 0.0),
      child: Row(children: [
        TextButton(
          child: Text("Accept",
              style: KTextSytle(
                      context: context,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  .getStyle()),
          onPressed: () {
            var state = getExperienceState(experience);
            if (state == "selected") {
              var expData = getExperienceValueByName(experience);
              if (expData["exptime"] <=
                  leftHours[currentDay.value].value * 60) {
                promoteExperience(experience, "promoted");
                Get.close(1);
              } else {
                showCustomDialog(
                  context,
                  Text("Too Many Selected Hours !!!!",
                      style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)
                          .getStyle()),
                  "Close",
                  backgroundColor: Colors.white,
                  buttonColor: Colors.black,
                );
              }
            }
          },
        ),
        TextButton(
          child: Text("Cancel",
              style: KTextSytle(
                      context: context,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  .getStyle()),
          onPressed: () {
            Get.close(1);
          },
        ),
      ]),
    );
  }
}
