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
        LeftWidget(experience: experience),
        RightWidget(experience: experience),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.51,
              top: MediaQuery.of(context).size.height * 0.8),
          child: CustomKeypadWidget(
              nextlabel: "Next >",
              prevlabel: " < Previous",
              onNext: () {
                globalctx.promoted.add(experience);
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



