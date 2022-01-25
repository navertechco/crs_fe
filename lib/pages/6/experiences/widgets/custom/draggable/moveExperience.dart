// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import '../../index.dart';

void moveExperienceFunction(String experience, BuildContext context) {
  if (!globalctx.experiences.contains(experience)) {
    globalctx.experiences.add(experience);
    globalctx.experienceDragData.value.add(Obx(() {
      return globalctx.experiences.contains(experience)
          ? Row(
              children: [
                ExperienceOptionWidget(
                    height: MediaQuery.of(context).size.height * 0.075,
                    width: MediaQuery.of(context).size.width * 0.2,
                    experience: experience),
                !globalctx.promoted.contains(experience)
                    ? GestureDetector(
                        onTap: () {
                          if (globalctx.experiences.contains(experience)) {
                            var index = globalctx.experiences
                                .indexWhere((element) => element == experience);
                            globalctx.experiences.removeAt(index);
                            globalctx.experienceDragData.value.removeAt(index);
                          }
                        },
                        child: Image.asset("assets/custom/img/redmark.png",
                            width: MediaQuery.of(context).size.width * 0.02),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (globalctx.experiences.contains(experience)) {
                            globalctx.promoted.remove(experience);
                            var index = globalctx.experiences
                                .indexWhere((element) => element == experience);
                            globalctx.experiences.removeAt(index);
                            globalctx.experienceDragData.value.removeAt(index);
                          }
                        },
                        child: Image.asset("assets/custom/img/greencheck.png",
                            width: MediaQuery.of(context).size.width * 0.02),
                      )
              ],
            )
          : Text("");
    }));
  }
}
