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
    required this.destination,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final int index;
  final destination;
  @override
  Widget build(BuildContext context) {
    List<Widget> daylist = [];
    var promotedDestinationDay = globalctx.memory["destinationDay"];
    var destindex = index;
    // > promotedDestinationDay.length - 1
    //     ? promotedDestinationDay.length - 1
    //     : index;
    var destination = promotedDestinationDay[destindex];
    var explorationDay = int.parse(destination["explorationDay"]);
    var title = destination["destination"].toString().capitalize;
    for (var day = 0; day < explorationDay; day++) {
      var key = GlobalKey();
      globalctx.keys["day-$destindex-$day"] = key;
      daylist.add(Column(
        children: [
          RepaintBoundary(
              // key: globalctx.keys["day-$index-$day"],
              child: CustomFormTitleWidget(level: 3, label: "$title")),
          CustomFormDayWidget(data: data, indexes: [destindex, day]),
        ],
      ));
    }

    return Column(
      children: daylist,
    );
  }
}
