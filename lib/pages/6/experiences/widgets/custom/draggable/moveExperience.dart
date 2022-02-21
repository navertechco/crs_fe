// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import '../../index.dart';

void moveExperienceFunction(String experience, BuildContext context) {
  if (!globalctx.experiences.contains(experience) &&
      globalctx.experienceDragData.value.isNotEmpty) {
    globalctx.experiences.add(experience);

    var index = currentDay.value;
    globalctx.experienceDragData.value[index] ??= [];
    globalctx.experienceDragData.value[index]!.add(Obx(() {
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
    }));
  }
}
