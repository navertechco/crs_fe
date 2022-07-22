import 'package:flutter/material.dart';
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
    var destindex = indexes[0];
    var dayindex = indexes[1];
    var experienceindex = indexes[2];
    var tour = globalctx.memory["tour"];
    var destinations = tour["destinations"];
    var destination;
    try {
      destination = destinations[destindex.toString()];
    } catch (e) {
      destination = destinations[destindex];
    }

    var daysData = destination["daysData"];
    var days = daysData.entries.toList();
    var day = days[dayindex].value;
    var dayexps = day['experiences'];
    var expList = dayexps.keys.toList();
    var expName = expList[experienceindex];
    var expData = getExperienceDataByName(expName);
    var cost = expData.value["cost"];
    var title = expName.toString();
    return Column(
      children: [
        CustomDescriptionWidget(
          text: "$title ",
          width: 0.6,
          fontSize: 0.016,
          fontWeight: FontWeight.bold,
        ),
        Text("\$ $cost"),
      ],
    );
  }
}
