import 'package:flutter/material.dart';
import '../../../../../index.dart';
import '../../index.dart';

class DragableExperience extends StatelessWidget {
  const DragableExperience({
    Key? key,
    required this.experience,
    required this.suggested,
  }) : super(key: key);

  final experience;
  final bool suggested;
  @override
  Widget build(BuildContext context) {
    var experienceOptionWidget = ExperienceOptionWidget(
      experience: experience.description,
      suggested: suggested,
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.2,
    );

    String title = experience.description;

    return Draggable<String>(
      maxSimultaneousDrags: expDraggable.value,
      data: title,
      feedback: experienceOptionWidget,
      childWhenDragging: experienceOptionWidget,
      child: experienceOptionWidget,
    );
  }
}
