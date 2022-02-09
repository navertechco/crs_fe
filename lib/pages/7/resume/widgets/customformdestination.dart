import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../../../index.dart';
import 'customformday.dart';
import 'customformtitle.dart';

class CustomFormDestination extends StatelessWidget {
  const CustomFormDestination({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final int index;
  @override
  Widget build(BuildContext context) {
    List<CustomFormDayWidget> daylist = [];
    var memory = globalctx.memory.value;
    var destinations = [
      "arrival",
      ...globalctx.promotedDestinations.value,
      "departure"
    ];
    var destination = destinations.toList()[index];
    var allDestinations = memory["destinations"];
    var destinationList = allDestinations.entries
        .map((e) => {"destination": e.key.toString(), ...e.value})
        .toList();
    List<dynamic> destinationData = [
      {"destination": "arrival", "explorationDay": "1"},
      ...destinationList,
      {"destination": "departure", "explorationDay": "1"}
    ];
    var explorationDay = int.parse(destinationData[index]["explorationDay"]);

    for (var day = 0; day < explorationDay; day++) {
      var key = GlobalKey();
      globalctx.keys["day-$index-$day"] = key;
      daylist.add(CustomFormDayWidget(data: data, indexes: [index, day]));
    }

    return Column(
      children: [
        RepaintBoundary(
            key: globalctx.keys["destination-$index"],
            child: CustomFormTitleWidget(
                level: 3,
                label:
                    "Star Destination ${index + 1}:#${destination.toString().capitalize}#(Between: ${currentDayFormat.format(arrivalDate.value)} and ${currentDayFormat.format(departureDate.value)})")),
        Column(
          children: daylist,
        ),
      ],
    );
  }
}
