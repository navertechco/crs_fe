// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

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
      index =
          type == "departure" ? destinationDragData.value.length + 1 : index;
      var explorationDay = getFormValue(
          globalctx.memory["destinations"], index, "explorationDay", "0");
      return validateShowSelectedDestination(destination, index, type, out)
          ? Row(
              children: [
                DestinationOptionWidget(
                    destination: destination, type: type, index: index),
                promotedDestinations
                        .where((p0) => p0[0] == destination && p0[1] == index)
                        .isEmpty
                    ? Column(
                        children: [
                          Text(explorationDay,
                              style: KTextSytle(
                                      context: context,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 204, 164, 61))
                                  .getStyle()),
                          GestureDetector(
                            onTap: () {
                              removeDestination(destination, type, index);
                            },
                            child: Image.asset("assets/custom/img/redmark.png",
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(explorationDay,
                              style: KTextSytle(
                                      context: context,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 204, 164, 61))
                                  .getStyle()),
                          GestureDetector(
                            onTap: () {
                              removeDestination(destination, type, index);
                            },
                            child: Image.asset(
                                "assets/custom/img/greencheck.png",
                                width: Get.width * 0.02),
                          ),
                        ],
                      ),
              ],
            )
          : Text("");
    });
  }
}
