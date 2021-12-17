import 'package:flutter/material.dart';
import './index.dart';

class ExperienceOptionWidget extends StatelessWidget {
  const ExperienceOptionWidget({Key? key, required this.experience})
      : super(key: key);
  final String experience;
  @override
  Widget build(BuildContext context) {
    return GoldBorderWidget(
        child: SwitcherWidget(
            experience: experience,
            firstchild: FrontOptionWidget(experience: experience),
            seccondchild: RearOptionWidget(experience: experience)));
  }
}
