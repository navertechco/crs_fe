import 'package:flutter/material.dart';
import '../../../index.dart';
import 'customdescription.dart';

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
    var destinations = globalctx.memory["destinations"];
    var destination = destinations[destinationindex.toString()];
    var daysData = destination["daysData"];
    var days = daysData.entries.toList();
    var day = days[dayindex].value;
    var dayexps = day['experiences'];
    var expList = dayexps.keys.toList();
    var expName = expList[experienceindex];
    var nextIndex = experienceindex + 1 < dayexps.length
        ? experienceindex + 1
        : experienceindex;
    var nextExpName = expList[nextIndex];
    var experience = dayexps[expName];
    var nextexperience = dayexps[nextExpName];
    var title = expName.toString();
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
