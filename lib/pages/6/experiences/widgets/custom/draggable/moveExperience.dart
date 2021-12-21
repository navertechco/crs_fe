// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import '../../index.dart';

void moveExperienceFunction(String experience, BuildContext context) {
  if (!globalctx.selected.contains(experience)) {
    globalctx.selected.add(experience);

    globalctx.experienceDragData.value.add(Obx(() {
      return globalctx.selected.contains(experience)
          ? Row(
              children: [
                ExperienceOptionWidget(
                  experience: experience,
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                !globalctx.promoted.contains(experience)
                    ? GestureDetector(
                        onTap: () {
                          removeExperience(experience);
                        },
                        child: Image.asset("assets/custom/img/redmark.png",
                            width: MediaQuery.of(context).size.width * 0.02),
                      )
                    : GestureDetector(
                        onTap: () {
                          removeExperience(experience);
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
