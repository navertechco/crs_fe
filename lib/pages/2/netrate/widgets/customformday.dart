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
      var destinationindex = indexes[0];
      var dayindex = indexes[1];
      var tour = globalctx["memory"]["tour"];
      var destinations = tour["destinations"];
      var destination = destinations[destinationindex.toString()];
      var daysData = destination["daysData"] ?? {};
      var days = daysData.entries.toList();
      var day = days[dayindex];
      var daydescription = day.value['day_description'] ?? '';
      var dayLabel =
          (destinationindex != 0 ? destinationindex + 1 : destinationindex) +
              (destinationindex == 0 ? dayindex + 1 : dayindex + 2);

      return RepaintBoundary(
          key: globalctx["keys"]["day-$destinationindex-$dayindex"],
          child: Column(
            children: [
              CustomFormTitleWidget(level: 4, label: "Day: $dayLabel#####"),
              CustomDescriptionWidget(
                  text: daydescription, width: 0.55, fontSize: 0.016),
              CustomFormExperiencesDetailWidget(indexes: indexes),
              CustomDescriptionWidget(
                  text: "Day Net Rate: 0", width: 0.55, fontSize: 0.016),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ));
    } catch (e) {
      return Text("ERROR: CustomFormDayWidget: $e");
    }
  }
}
