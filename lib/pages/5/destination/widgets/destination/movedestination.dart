import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../index.dart';
import '../index.dart';

void moveDestinationFunction(String destination, BuildContext context) {
  var dayleft = Rx(getContext("dayleft"));
  if (!globalctx.destinations.contains(destination) && dayleft.value != 0) {
    globalctx.destinations.add(destination);
    globalctx.destinationDragData.value.add(Obx(() {
      return globalctx.destinations.contains(destination)
          ? Row(
              children: [
                DestinationOptionWidget(destination: destination),
                !globalctx.promoted.contains(destination)
                    ? GestureDetector(
                        onTap: () {
                          if (globalctx.destinations.contains(destination)) {
                            var index = globalctx.destinations.indexWhere(
                                (element) => element == destination);
                            globalctx.destinations.removeAt(index);
                            globalctx.destinationDragData.value.removeAt(index);
                          }
                        },
                        child: Image.asset("assets/custom/img/redmark.png",
                            width: MediaQuery.of(context).size.width * 0.02),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (globalctx.destinations.contains(destination)) {
                            globalctx.promoted.remove(destination);
                            var index = globalctx.destinations.indexWhere(
                                (element) => element == destination);
                            globalctx.destinations.removeAt(index);
                            globalctx.destinationDragData.value.removeAt(index);
                          }
                        },
                        child: Image.asset("assets/custom/img/greencheck.png",
                            width: MediaQuery.of(context).size.width * 0.02),
                      )
              ],
            )
          : Text("");
    }));
  }
}
