import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     CustomTitleWidget(
        //       fontWeight: FontWeight.bold,
        //       label: "Date: ",
        //     ),
        //     Obx(() {
        //       var days = 0;

        //       for (var i = 0; i < currentDay.value - 1; i++) {
        //         days += 1;
        //       }

        //       var date = currentDayFormat
        //           .format(arrivalDate.value.add(Duration(days: days)));

        //       if (globalDestination.value == "arrival") {
        //         date = currentDayFormat.format(arrivalDate.value);
        //       }
        //       if (globalDestination.value == "departure") {
        //         date = currentDayFormat.format(departureDate.value);
        //       }

        //       return CustomTitleWidget(
        //         fontWeight: FontWeight.bold,
        //         label: date,
        //       );
        //     }),
        //   ],
        // ),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
        // Obx(() {
        //   var airport = getDestinationAirport();

        //   return Row(
        //     children: [
        //       if (globalDestination.value != "arrival")
        //         CustomTitleWidget(
        //           fontWeight: FontWeight.bold,
        //           label: "Destination: $globalDestination",
        //         ),
        //       if (globalDestination.value != "arrival")
        //         SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        //       CustomTitleWidget(
        //         fontWeight: FontWeight.bold,
        //         label: "Airport: ${airport.toString()}",
        //       ),
        //     ],
        //   );
        // }),
        Divider(color: Color.fromARGB(255, 0, 0, 0)),
      ],
    );
  }
}
