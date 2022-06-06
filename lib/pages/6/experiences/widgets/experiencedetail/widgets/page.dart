// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';


class ExperienceDetailWidget extends GetView<ExperienceDetailController> {
  const ExperienceDetailWidget({Key? key, this.experience}) : super(key: key);
  final experience;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.0,
                top: MediaQuery.of(context).size.height * 0.0),
            child: Column(
              children: [
                TitleWidget(experience: experience),
                CarouselWidget(experience: experience),
                DescriptionWidget(experience: experience),
                if (getExperienceState(experience) != "suggested")
                  KeypadWidget(experience: experience),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
