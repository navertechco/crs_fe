import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'customdescription.dart';

class CustomFormExperienceRowWidget extends StatelessWidget {
  const CustomFormExperienceRowWidget({
    Key? key,
    required this.indexes,
  }) : super(key: key);
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    try {
      var destId = indexes[0];
      var destDay = indexes[1];
      var experienceindex = indexes[2];
      var promoted = globalctx.memory["promoted"][destDay];
      for (var exp in promoted) {
        expList.add(exp.key);
      }
      var expName = expList[experienceindex];
      var nextIndex = experienceindex + 1 < promoted.length
          ? experienceindex + 1
          : experienceindex;
      var nextExpName = expList[nextIndex];
      var experience = getExperienceByName(expName);
      var nextexperience = promoted[nextExpName];
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
    } catch (e) {
      return Text("Error of CustomFormExperienceRowWidget: $e");
    }
  }
}
