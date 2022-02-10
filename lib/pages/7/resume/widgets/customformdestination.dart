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
    List<Widget> daylist = [];
    var destination = promotedDestinations.toList()[index];
    var explorationDay =
        int.parse(customDestinationData[index]["explorationDay"]);
    for (var day = 0; day < explorationDay; day++) {
      var key = GlobalKey();
      globalctx.keys["day-$index-$day"] = key;
      daylist.add(Column(
        children: [
          RepaintBoundary(
              // key: globalctx.keys["day-$index-$day"],
              child: CustomFormTitleWidget(
                  level: 3, label: "${destination.toString().capitalize}")),
          CustomFormDayWidget(data: data, indexes: [index, day]),
        ],
      ));
    }

    return Column(
      children: daylist,
    );
  }
}
