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
    var destinationindex = indexes[0];
    var dayindex = indexes[1];
    var destination = customDestinationData[destinationindex]["destination"];
    var days = globalctx.memory['days'];
    var day = days[dayindex];
    var daydate = day['date'];
    var meals = day['meals'];
    var observation = day['observation'];
    var daydescription = day['day_description'];
    return RepaintBoundary(
        key: globalctx.keys["day-$destinationindex-$dayindex"],
        child: Column(
          children: [
            CustomFormTitleWidget(
                level: 4,
                label:
                    "Day: ${destination == "departure" ? totalDays : dayindex + 1}#####Date: $daydate"),
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
  }
}
