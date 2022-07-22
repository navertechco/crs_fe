import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
      var daysData = destination["daysData"] ?? {};
      var days = daysData.entries.toList();
      var day = days[dayindex];
      var daydescription = day.value['day_description'] ?? '';
      var dayLabel = (destindex != 0 ? destindex + 1 : destindex) +
          (destindex == 0 ? dayindex + 1 : dayindex + 2);
      var actualcost = 0.obs;
      var cost = getFormValue(globalctx.memory, "netRate", destindex, 0);
      actualcost.value = cost;
      return RepaintBoundary(
          key: globalctx.keys["day-$destindex-$dayindex"],
          child: Column(
            children: [
              CustomFormTitleWidget(level: 4, label: "Day: $dayLabel#####"),
              CustomDescriptionWidget(
                  text: daydescription, width: 0.55, fontSize: 0.016),
              CustomFormExperiencesDetailWidget(indexes: indexes),
              CustomDescriptionWidget(
                  text: "Day Net Rate: \$ $actualcost",
                  width: 0.55,
                  fontSize: 0.016),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ));
    } catch (e) {
      return Text("ERROR: CustomFormDayWidget: $e");
    }
  }
}
