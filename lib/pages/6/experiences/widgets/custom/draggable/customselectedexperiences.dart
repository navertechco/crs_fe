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
    return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            // width: MediaQuery.of(context).size.width * 0.1,
            child: Column(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Selected Experiences\n",
            ),
            const Divider(
              color: Colors.black,
              height: 25,
              thickness: 2,
              indent: 5,
              endIndent: 5,
            ),
            Scrollbar(
              child: SingleChildScrollView(
                child: ExperienceDragTargetWidget(
                  onAccept: (String experience) {
                    setContext("experienceContext", context);
                    moveExperienceFunction(experience, context);
                    setExperienceState(experience, "selected");
                  },
                ),
              ),
            ),
          ],
        )));
  }
}
