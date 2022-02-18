import 'package:flutter/material.dart';

import '../../../../../index.dart';
import '../../index.dart';

class CustomSugestedExperiencesWidget extends StatelessWidget {
  const CustomSugestedExperiencesWidget({
    Key? key,  required this.ctrl,
  }) : super(key: key);
final ExperiencesController ctrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Suggested Experiences\n_______________________________",
        ),
        CustomExperiencesListWidget(  ctrl:ctrl),
      ],
    );
  }
}
