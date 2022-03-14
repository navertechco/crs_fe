import 'package:flutter/material.dart';
import 'package:naver_crs/pages/6/experiences/controller.dart';

import '../../index.dart';

class CustomContentWidget extends StatelessWidget {
  const CustomContentWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  final ExperiencesController ctrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSugestedExperiencesWidget(ctrl: ctrl),
        CustomSelectedExperiencesWidget(),
      ],
    );
  }
}
