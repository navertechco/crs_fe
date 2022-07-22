import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'customformexperience.dart';

class CustomFormExperiencesDetailWidget extends StatelessWidget {
  const CustomFormExperiencesDetailWidget({
    Key? key,
    required this.indexes,
  }) : super(key: key);
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    var destindex = indexes[0];
    var dayindex = indexes[1];
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
    var actualCost = 0;
    List<Widget> list = [];

    for (var i = 0; i < dayexps.length; i++) {
      var expName = expList[i];
      var expData = getExperienceDataByName(expName);
      int cost = expData.value["cost"];
      actualCost += cost;
      list.add(
          CustomFormExperienceRowWidget(indexes: [destindex, dayindex, i]));
    }
    setFormValue(globalctx.memory, "netRate", destindex, actualCost);
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: list,
      ),
    );
  }
}
