// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'customdescription.dart';
import 'customformexperiencedetail.dart';
import 'customformtitle.dart';

class CustomFormDayWidget extends StatelessWidget {
  const CustomFormDayWidget({
    Key? key,
    required this.indexes,
  }) : super(key: key);

  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    try {
      var destId = indexes[0];
      var destDay = indexes[1];
      var dayId = getCurrentDestinationDayId(destId, destDay);
      indexes[1] = dayId;
      var destinations = getCombinedDestinations();
      var destination = destinations[destId.toString()];
      var destData = getDestinationValueByName(destination["destination"]);
      var daydescription = destData[8];
      return RepaintBoundary(
          key: Key("day-$destId-$destDay"),
          child: Column(
            children: [
              CustomFormTitleWidget(
                  level: 4,
                  label: dayId == 0
                      ? "Arrival"
                      : dayId == destDays.length - 1
                          ? "Departure"
                          : "Day: $dayId#####"),
              CustomDescriptionWidget(
                  text: daydescription, width: 0.55, fontSize: 0.016),
              CustomFormExperiencesDetailWidget(indexes: indexes),
            ],
          ));
    } catch (e) {
      return Text('');
    }
  }
}
