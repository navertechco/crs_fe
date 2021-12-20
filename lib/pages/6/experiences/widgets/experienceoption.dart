import 'package:flutter/material.dart';
import './index.dart';

class ExperienceOptionWidget extends StatelessWidget {
  const ExperienceOptionWidget(
      {Key? key, required this.experience, this.height = 100, this.width = 100})
      : super(key: key);
  final String experience;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GoldBorderWidget(
          child: SwitcherWidget(
              experience: experience,
              firstchild: FrontOptionWidget(experience: experience),
              seccondchild: RearOptionWidget(experience: experience))),
    );
  }
}
