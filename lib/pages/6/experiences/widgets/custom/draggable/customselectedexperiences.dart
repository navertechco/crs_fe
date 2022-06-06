import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/draggable/experiencedragtarget.dart';

class CustomSelectedExperiencesWidget extends StatelessWidget {
  const CustomSelectedExperiencesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // width: MediaQuery.of(context).size.width * 0.1,
        child: Column(
      children: [
        CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Selected Experiences",
            color: Colors.white),
        const Divider(
          color: Colors.black,
          height: 20,
          thickness: 2,
          indent: 5,
          endIndent: 5,
        ),
        Scrollbar(
          child: SingleChildScrollView(
            child: ExperienceDragTargetWidget(
              onAccept: (String experience) {
                if (experience == "Leisure Time" &&
                    leftHours[currentDay.value].value <= 0) {
                  return;
                } else {
                  promoteExperience(experience, "promoted");
                }
              },
            ),
          ),
        ),
      ],
    ));
  }
}
