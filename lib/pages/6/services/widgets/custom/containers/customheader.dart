import 'package:flutter/material.dart';

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

        //       if (globalDestinationName.value == "arrival") {
        //         date = currentDayFormat.format(arrivalDate.value);
        //       }
        //       if (globalDestinationName.value == "departure") {
        //         date = currentDayFormat.format(departureDate.value);
        //       }

        //       return CustomTitleWidget(
        //         fontWeight: FontWeight.bold,
        //         label: date,
        //       );
        //     }),
        //   ],
        // ),

        // Obx(() {
        //   var airport = getDestinationAirport();

        //   return Row(
        //     children: [
        //       if (globalDestinationName.value != "arrival")
        //         CustomTitleWidget(
        //           fontWeight: FontWeight.bold,
        //           label: "Destination: $globalDestination",
        //         ),
        //       if (globalDestinationName.value != "arrival")
        //         SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        //       CustomTitleWidget(
        //         fontWeight: FontWeight.bold,
        //         label: "Airport: ${airport.toString()}",
        //       ),
        //     ],
        //   );
        // }),
      ],
    );
  }
}
