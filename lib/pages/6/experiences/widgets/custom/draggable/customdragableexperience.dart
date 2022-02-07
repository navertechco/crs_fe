import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';
import '../../index.dart';

class CustomDragableExperience extends StatelessWidget {
  const CustomDragableExperience({
    Key? key,
    required this.experience,
    required this.suggested,
  }) : super(key: key);

  final String experience;
  final bool suggested;
  @override
  Widget build(BuildContext context) {
    var experienceOptionWidget = ExperienceOptionWidget(
      experience: experience,
      suggested: suggested,
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.2,
    );
    return Obx(() {
      var state = Rx(globalctx.states["experiences"][experience]["state"]);
      return state.value == "suggested"
          ? Draggable<String>(
              data: experience,
              feedback: experienceOptionWidget,
              childWhenDragging: experienceOptionWidget,
              child: experienceOptionWidget,
            )
          : Text("");
    });
  }
}
