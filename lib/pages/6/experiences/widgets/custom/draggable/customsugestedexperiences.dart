import 'package:flutter/material.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/draggable/experiencedragtarget.dart';

import '../../../../../index.dart';


class CustomSugestedExperiencesWidget extends StatelessWidget {
  const CustomSugestedExperiencesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Sugested Experiences\n______________________________________",
        ),
        Scrollbar(
          child: SingleChildScrollView(
            child: ExperienceDragTargetWidget(onAccept: (String? key){},),
          ),
        ),
      ],
    );
  }
}
