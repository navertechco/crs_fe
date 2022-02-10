
import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customdescription.dart';
import 'resume.dart';

class CustomFormExperienceRowWidget extends StatelessWidget {
  const CustomFormExperienceRowWidget({
    Key? key,
    required this.data,
    required this.indexes,
  }) : super(key: key);
  final Map<String, dynamic> data;
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    var destinationindex = indexes[0];
    var dayindex = indexes[1];
    var experienceindex = indexes[2];
    var memory = globalctx.memory;
    var day = memory['destinationDay'][destinationindex]['days'][dayindex];
    var experiences = day['experiences'];
    var experience = experiences[experienceindex];
    var nextexperience = experienceindex + 1 < experiences.length
        ? experiences[experienceindex + 1]
        : experience;
    var title = experience['title'].toString();
    var description = experience['description'].toString();
    var next = experience['next'].toString() != ""
        ? experience['next'].toString()
        : nextexperience['previous'].toString();

    return Column(
      children: [
        CustomDescriptionWidget(
          text: "$title ",
          width: 0.6,
          fontSize: 0.016,
          fontWeight: FontWeight.bold,
        ),
        Image.asset(
          "assets/custom/img/1x/Recurso_374mdpi.png",
        ),
        CustomDescriptionWidget(
          text: description,
          width: 0.6,
          fontSize: 0.016,
          fontWeight: FontWeight.normal,
        ),
        if (next != "null")
          CustomDescriptionWidget(
            text: "Next: $next",
            width: 0.6,
            fontSize: 0.016,
            fontWeight: FontWeight.bold,
          ),
      ],
    );
  }
}
