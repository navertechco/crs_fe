import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';
import '../../index.dart';

class DragExperienceOptionWidget extends StatelessWidget {
  final String experience;
  const DragExperienceOptionWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var state = Rx(getExperienceState(experience));
      return state.value != "suggested"
          ? Row(
              children: [
                ExperienceOptionWidget(
                    height: Get.height * 0.075,
                    width: Get.width * 0.2,
                    experience: experience),
                state.value != "promoted"
                    ? GestureDetector(
                        onTap: () {
                          setExperienceState(experience, "suggested");
                        },
                        child: Image.asset("assets/custom/img/redmark.png",
                            width: Get.width * 0.02),
                      )
                    : GestureDetector(
                        onTap: () {
                          setExperienceState(experience, "suggested");
                        },
                        child: Image.asset("assets/custom/img/greencheck.png",
                            width: Get.width * 0.02),
                      )
              ],
            )
          : Text("");
    });
  }
}
