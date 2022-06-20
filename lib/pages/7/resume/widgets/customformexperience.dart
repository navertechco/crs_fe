import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/pages/7/resume/widgets/header.dart';
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
      var expList = [];
      var destDay = indexes[1];
      var experienceindex = indexes[2];
      var promoted = globalctx.memory["promoted"].entries.toList();
      var promotedDay = promoted[destDay];
      var promotedList = promotedDay.value.keys.toList();
      for (var exp in promotedList) {
        expList.add(exp);
      }
      promoted = promotedDay.value;
      var expName = expList[experienceindex];
      var nextIndex = experienceindex + 1 < promoted.length
          ? experienceindex + 1
          : experienceindex;
      var nextExpName = expList[nextIndex];
      var experience = getExperienceByName(expName);
      var experienceType = experience.value["experience_type"];
      var nextexperience = promoted[nextExpName];
      var title = expName.toString();
      var description = experience.description.toString();
      var next = nextexperience['description'].toString();

      return Column(
        children: [
          CustomDescriptionWidget(
            text: "$title ",
            width: 0.6,
            fontSize: 0.016,
            fontWeight: FontWeight.bold,
          ),
          if (experienceType == "meal")
            OptionField(
                onChange: (value) {},
                label: "\t\tMeal Option (A, B, C, D):\t\t\t\t",
                data: [0, 1, 2, 3]),
          Image.asset(
            "assets/images/1x/Recurso_374mdpi.png",
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
