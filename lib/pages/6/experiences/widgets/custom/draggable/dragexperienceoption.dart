import 'package:flutter/material.dart';
import '../../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class DragExperienceTarget extends StatelessWidget {
  final String experience;
  const DragExperienceTarget({
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
                          promoteExperience(experience, "suggested");
                        },
                        child: Image.asset("assets/images/1/redmark.png",
                            width: Get.width * 0.02),
                      )
                    : GestureDetector(
                        onTap: () {
                          promoteExperience(experience, "suggested");
                        },
                        child: Image.asset("assets/images/1/greencheck.png",
                            width: Get.width * 0.02),
                      )
              ],
            )
          : Text('');
    });
  }
}
