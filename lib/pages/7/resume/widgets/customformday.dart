// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customdescription.dart';
import 'customformexperiencedetail.dart';
import 'customformtitle.dart';

class CustomFormDayWidget extends StatelessWidget {
  const CustomFormDayWidget({
    Key? key,
    required this.data,
    required this.indexes,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    try {
      var destId = indexes[0];
      var destDay = indexes[1];
      var dayId = getDayId(destId, destDay);
      var destinations = getCombinedDestinations();
      var destination = destinations[destId.toString()];
      var memory = globalctx.memory;
      var daysData = memory["destinationDay"][destId] ?? {};
      var promoted = memory["promoted"]["day"][destDay] ?? {};

      return RepaintBoundary(
          key: globalctx.keys["day-$destId-$destDay"],
          child: Column(
            children: [
              // CustomFormTitleWidget(level: 4, label: "Day: $dayLabel#####"),
              // CustomDescriptionWidget(
              //     text: daydescription, width: 0.55, fontSize: 0.016),
              // CustomFormExperiencesDetailWidget(data: data, indexes: indexes),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // if (observation != null)
              //   CustomDescriptionWidget(
              //     text: "Observation: $observation",
              //     width: 0.55,
              //     fontSize: 0.016,
              //     fontWeight: FontWeight.bold,
              //   ),
              // CustomDescriptionWidget(
              //     text: "Meals: $meals",
              //     width: 0.55,
              //     fontSize: 0.016,
              //     fontWeight: FontWeight.bold),
            ],
          ));
    } catch (e) {
      return Text("");
    }
  }
}
