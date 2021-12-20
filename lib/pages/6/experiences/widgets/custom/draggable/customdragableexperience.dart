import 'package:flutter/material.dart';

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
    return Draggable<String>(
      // Data is the value this Draggable stores.
      data: experience,
      feedback: CustomExperienceOptionWidget(
          experience: experience, suggested: suggested),
      childWhenDragging: CustomExperienceOptionWidget(
          experience: experience, suggested: suggested),
      child: CustomExperienceOptionWidget(
          experience: experience, suggested: suggested),
    );
  }
}
