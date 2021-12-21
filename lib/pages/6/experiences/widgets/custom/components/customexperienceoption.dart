import 'package:flutter/material.dart';

import '../../../../../index.dart';
import '../../index.dart';

class CustomExperienceOptionWidget extends StatelessWidget {
  const CustomExperienceOptionWidget({
    Key? key,
    required this.experience,
    required this.suggested,
  }) : super(key: key);

  final experience;
  final bool suggested;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (globalctx.suggested.contains(experience) && suggested)
          Row(
            children: [
              ExperienceOptionWidget(
                experience: experience,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              if (globalctx.promoted.contains(experience) && !suggested)
                Image.asset("assets/custom/img/greencheck.png",
                    width: MediaQuery.of(context).size.width * 0.02),
              if (!globalctx.promoted.contains(experience) && !suggested)
                Image.asset("assets/custom/img/redmark.png",
                    width: MediaQuery.of(context).size.width * 0.02)
            ],
          ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}
