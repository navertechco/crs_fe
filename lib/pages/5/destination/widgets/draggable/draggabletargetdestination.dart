import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../index.dart';
import '../index.dart';

class DraggableTargetDestinationWidget extends StatelessWidget {
  const DraggableTargetDestinationWidget({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final String destination;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return globalctx.destinations.contains(destination)
          ? Row(
              children: [
                DestinationOptionWidget(destination: destination),
                !globalctx.promoted.contains(destination)
                    ? GestureDetector(
                        onTap: () {
                          if (globalctx.destinations.contains(destination)) {
                            globalctx.promoted.remove(destination);
                            var index = globalctx.destinations.indexWhere(
                                (element) => element == destination);
                            globalctx.destinations.removeAt(index);
                            globalctx.destinationDragData.value
                                .removeAt(index);
                          }
                        },
                        child: Image.asset(
                            "assets/custom/img/redmark.png",
                            width: MediaQuery.of(context).size.width *
                                0.02),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (globalctx.destinations.contains(destination)) {
                            var index = globalctx.destinations.indexWhere(
                                (element) => element == destination);
                            globalctx.destinations.removeAt(index);
                            globalctx.destinationDragData.value
                                .removeAt(index);
                          }
                        },
                        child: Image.asset(
                            "assets/custom/img/greencheck.png",
                            width: MediaQuery.of(context).size.width *
                                0.02),
                      )
              ],
            )
          : Text("");
    });
  }
}
