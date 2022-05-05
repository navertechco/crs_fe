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
      var destinationindex = indexes[0];
      var dayindex = indexes[1];
      var destinations = getCombinedDestinations();
      var destination = destinations[destinationindex.toString()];
      var daysData = destination["daysData"] ?? {};
      var days = daysData.entries.toList();
      var day = days[dayindex];
      var meals = day['meals'];
      var observation = day['observation'];
      var daydescription = day['day_description'];
      var dayLabel =
          (destinationindex != 0 ? destinationindex + 1 : destinationindex) +
              (destinationindex == 0 ? dayindex + 1 : dayindex + 2);

      return RepaintBoundary(
          key: globalctx.keys["day-$destinationindex-$dayindex"],
          child: Column(
            children: [
              CustomFormTitleWidget(level: 4, label: "Day: $dayLabel#####"),
              CustomDescriptionWidget(
                  text: daydescription, width: 0.55, fontSize: 0.016),
              CustomFormExperiencesDetailWidget(data: data, indexes: indexes),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              if (observation != null)
                CustomDescriptionWidget(
                  text: "Observation: $observation",
                  width: 0.55,
                  fontSize: 0.016,
                  fontWeight: FontWeight.bold,
                ),
              CustomDescriptionWidget(
                  text: "Meals: $meals",
                  width: 0.55,
                  fontSize: 0.016,
                  fontWeight: FontWeight.bold),
            ],
          ));
    } catch (e) {
      return Text("ERROR: CustomFormDayWidget: $e");
    }
  }
}
