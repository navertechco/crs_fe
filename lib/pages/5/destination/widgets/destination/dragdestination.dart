// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/context/index.dart';

import '../../../../index.dart';
import '../index.dart';

// ignore: must_be_immutable
class DragDestinationWidget extends StatelessWidget {
  String destination;
  String type;
  int index;
  bool out;
  DragDestinationWidget({
    Key? key,
    required this.destination,
    required this.type,
    required this.index,
    this.out = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return globalctx.destinations.contains(destination) &&
              ((!out && type == "tour") || (out && type != "tour"))
          ? Row(
              children: [
                DestinationOptionWidget(
                    destination: destination, type: type, index: index),
                !globalctx.promotedDestinations.contains(index)
                    ? GestureDetector(
                        onTap: () {
                          if (arrivalPort.value !=
                                  getDestinationIdByName(destination) &&
                              departurePort.value !=
                                  getDestinationIdByName(destination) &&
                              globalctx.destinations.contains(destination)) {
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
                          if (arrivalPort.value !=
                                  getDestinationIdByName(destination) &&
                              departurePort.value !=
                                  getDestinationIdByName(destination) &&
                              globalctx.destinations.contains(destination)) {
                            globalctx.promotedDestinations.remove(destination);
                            var index = globalctx.destinations.indexWhere(
                                (element) => element == destination);
                            globalctx.destinations.removeAt(index);
                            globalctx.destinationDragData.value.removeAt(index);
                          }
                        },
                        child: Image.asset("assets/custom/img/greencheck.png",
                            width: Get.width * 0.02),
                      )
              ],
            )
          : Text("");
    });
  }
}
