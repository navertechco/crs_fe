import 'package:flutter/material.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/draggable/experiencedragtarget.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/draggable/moveExperience.dart';
import '../../../../../index.dart'; 

class CustomSelectedExperiencesWidget extends StatelessWidget {
  const CustomSelectedExperiencesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Selected Experiences\n______________________________________",
        ),
        Scrollbar(
          child: SingleChildScrollView(
            child: ExperienceDragTargetWidget(
              onAccept: (String? key) {
                moveExperienceFunction(key!, context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
