import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../index.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<DateTime> arrivalDate = Rx(globalctx.memory["tour"]["arrival_date"]);
    Rx<DateTime> departureDate = Rx(globalctx.memory["tour"]["departure_date"]);
    Rx<int> totalDays =
        Rx(departureDate.value.difference(arrivalDate.value).inDays);
    final currentDayFormat = DateFormat('EEEE MMMM d yyyy');
    return Column(
      children: [
        Row(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Date: ",
            ),
            Obx(() {
              return CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label:
                    "${currentDayFormat.format(arrivalDate.value.add(Duration(days: currentDay.value)))}",
              );
            }),
          ],
        ),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
        Obx(() {
          return CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label:
                "Destination: ${processDays(currentDay)["destination"].toString().capitalize}",
          );
        }),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
      ],
    );
  }
}
