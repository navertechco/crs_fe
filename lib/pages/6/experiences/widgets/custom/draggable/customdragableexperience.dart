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
    var experienceOptionWidget = ExperienceOptionWidget(
      experience: experience,
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.2,
    );
    return Draggable<String>(
      // Data is the value this Draggable stores.
      data: experience,
      feedback: experienceOptionWidget,
      childWhenDragging: experienceOptionWidget,
      child: experienceOptionWidget,
    );
  }
}
