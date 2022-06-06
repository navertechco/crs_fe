import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';

class ExperienceOptionWidget extends StatelessWidget {
  const ExperienceOptionWidget(
      {Key? key,
      required this.experience,
      this.height = 80,
      this.width = 250,
      this.suggested = false})
      : super(key: key);
  final String experience;
  final double height;
  final double width;
  final bool suggested;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: GoldBorderWidget(
            child: SwitcherWidget(
                suggested: suggested,
                experience: experience,
                firstchild: ExperienceFrontOptionWidget(experience: experience),
                seccondchild:
                    ExperienceRearOptionWidget(experience: experience))));
  }
}
