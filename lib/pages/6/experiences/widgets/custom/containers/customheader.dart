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
    return Column(
      children: [
        Row(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Date: ",
            ),
            Obx(() {
              var days = 0;

              for (var i = 0; i < currentDay.value - 1; i++) {
                days += 1;
              }

              var date = currentDayFormat
                  .format(arrivalDate.value.add(Duration(days: days)));

              if (destination.value == "arrival") {
                date = currentDayFormat.format(arrivalDate.value);
              }
              if (destination.value == "departure") {
                date = currentDayFormat.format(departureDate.value);
              }

              return CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "${date}",
              );
            }),
          ],
        ),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
        Obx(() {
          var destination = processDays(currentDay)["destination"];
          var airport = getDestinationAirport(destination);

          return Row(
            children: [
              if (destination != "arrival")
                CustomTitleWidget(
                  fontWeight: FontWeight.bold,
                  label: "Destination: ${destination}",
                ),
              if (destination != "arrival")
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "Airport: ${airport.toString()}",
              ),
            ],
          );
        }),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
      ],
    );
  }
}
