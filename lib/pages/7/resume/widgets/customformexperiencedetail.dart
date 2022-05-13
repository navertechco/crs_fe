import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customformexperience.dart';

class CustomFormExperiencesDetailWidget extends StatelessWidget {
  const CustomFormExperiencesDetailWidget({
    Key? key,
    required this.indexes,
  }) : super(key: key);
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    try {
      var destId = indexes[0];
      var destDay = indexes[1];
      var destinationDay = globalctx.memory["destinations"];
      var destination = destinationDay[destId.toString()];
      var daysData = getDestinationValueByName(destination["destination"]);
      var days = globalctx.memory["days"];
      var dayId = getDayId(destId, destDay);
      var day = days[dayId.toString()].value;
      var dayexps = day.entries.toList();
      List<CustomFormExperienceRowWidget> list = [];

      for (var i = 0; i < dayexps.length; i++) {
        list.add(CustomFormExperienceRowWidget(indexes: [destId, destDay, i]));
      }

      return Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: list,
        ),
      );
    } catch (e) {
      return Text("");
      return Text("Error of CustomFormExperiencesDetailWidget: $e");
    }
  }
}

