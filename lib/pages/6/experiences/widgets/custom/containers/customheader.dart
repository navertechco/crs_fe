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

    final currentDayFormat = DateFormat('EEEE MMMM d yyyy');
    getAirport(Rx(1));
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
          var current = processDays(currentDay);
          var destination = current["destination"].toString();

          var data = getContext("current");

          return Row(
            children: [
              if (destination != "arrival")
                CustomTitleWidget(
                  fontWeight: FontWeight.bold,
                  label: "Destination: ${destination.capitalize}",
                ),
              if (destination != "arrival")
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "Airport: ${data.toString()}",
              ),
            ],
          );
        }),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
      ],
    );
  }
}
