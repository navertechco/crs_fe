import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class CustomDragableDestination extends StatelessWidget {
  const CustomDragableDestination({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final String destination;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Draggable<String>(
        // Data is the value this Draggable stores.
        maxSimultaneousDrags: destDraggable.value,
        data: destination,
        feedback:
            DestinationOptionWidget(destination: destination, isListed: true),
        childWhenDragging:
            DestinationOptionWidget(destination: destination, isListed: true),
        child:
            DestinationOptionWidget(destination: destination, isListed: true),
      );
    });
  }
}
