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
                TextButton(
                  onPressed: () {
                    promoteExperience(experience, "suggested");
                  },
                  child: Image.asset(
                      state.value != "promoted"
                          ? "assets/images/1x/redmark.png"
                          : "assets/images/1x/greencheck.png",
                      width: Get.width * 0.02),
                )
              ],
            )
          : Text('');
    });
  }
}
