// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import '../index.dart';
import 'index.dart';

class ExperienceDetailWidget extends GetView<ExperienceDetailController> {
  const ExperienceDetailWidget({Key? key, this.experience}) : super(key: key);
  final experience;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TitleWidget(experience: experience),
        LeftWidget(experience: experience),
        Image.asset("assets/custom/img/experience.edge.png",
            fit: BoxFit.fill, height: MediaQuery.of(context).size.height),
        RightWidget(experience: experience),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.51,
              top: MediaQuery.of(context).size.height * 0.8),
          child: CustomKeypadWidget(
              nextlabel: "Accept >",
              prevlabel: " < Cancel",
              onNext: () {
                promoteDayExperience(experience);
                setExperienceState(experience, "promoted");
                Get.close(1);
              },
              onPrevious: () {
                Get.close(1);
              },
              width: 0.3),
        ),
      ],
    );
  }
}
