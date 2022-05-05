import 'package:flutter/material.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/draggable/experiencedragtarget.dart';
import '../../../../../index.dart';

class CustomSelectedServicesWidget extends StatelessWidget {
  const CustomSelectedServicesWidget({
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
            label: "Selected Services",
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
                setExperienceState(experience, "selected");
              },
            ),
          ),
        ),
      ],
    ));
  }
}
