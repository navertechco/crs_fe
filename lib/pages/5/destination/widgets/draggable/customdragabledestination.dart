import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

import '../../../../index.dart';
import '../index.dart';

class CustomDragableDestination extends StatelessWidget {
  const CustomDragableDestination({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final String destination;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var rule1 = !globalctx.selectedDestinations.contains(destination);
      if (rule1) {
        return Draggable<String>(
          // Data is the value this Draggable stores.
          maxSimultaneousDrags: destDraggable.value,
          data: destination,
          feedback: DestinationOptionWidget(destination: destination),
          childWhenDragging: DestinationOptionWidget(destination: destination),
          child: DestinationOptionWidget(destination: destination),
        );
      } else {
        return Container();
      }
    });
  }
}
